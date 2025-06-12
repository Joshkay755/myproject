import 'package:file_picker/file_picker.dart';
import 'package:finalproject_admin/firebase_service.dart';
import 'package:finalproject_admin/widgets/categories_list_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'category';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseService _service = FirebaseService();
  final TextEditingController _catName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic image;
  String? fileName;


  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if(result!=null){
        setState(() {
          image = result.files.first.bytes;
          fileName = result.files.first.name;
        });
      } else {
        print('Cancelled or Failed');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }


  saveImageToDb()async{
    EasyLoading.show();
    var ref = FirebaseStorage.instance.ref('categoryImage/$fileName');
    try {
      String? mimeType = mime(basename(fileName!),);
      var metaData = SettableMetadata(contentType: mimeType);
      TaskSnapshot uploadSnapshot = await ref.putData(image,metaData);
      String downloadURL = await uploadSnapshot.ref.getDownloadURL().then((value) {
        if(value.isNotEmpty){
         _service.saveCategory(data: {
           'catName' : _catName.text,
           'image' : value,
           'active': true
         },
           docName: _catName.text,
           reference: _service.categories
         ).then((value) {
           clear();
           EasyLoading.dismiss();
         });
        }
        return value;
      });
    } on FirebaseException catch (e) {
      clear();
      EasyLoading.dismiss();
      print(e.toString());
    }
  }
  clear(){
    setState(() {
      _catName.clear();
      image = null;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
        
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade700),
                      ),
                      child: Center(child: image==null ? const Text('Category Image'):Image.memory(image, fit: BoxFit.cover,),),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: pickImage,
                        child:const Text('Upload Image'),
                    )
                  ],
                ),
                SizedBox(width: 20,),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Category Name';
                      }
                      return null;
                    },
                    controller: _catName,
                    decoration: const InputDecoration(
                      label: Text('Enter Category Name'),
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                TextButton(onPressed: clear,
                  child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor),),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    side: WidgetStateProperty.all(BorderSide(color: Theme.of(context).primaryColor),)
                  ),
                ),
                const SizedBox(width: 10,),
                image == null ? Container(): ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      saveImageToDb();
                    }
                  },
                  child: const Text('  Save  '),),
        
              ],
            ),
            const Divider(
              color: Colors.grey,
        
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category List',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            CategoriesListWidget(
              reference: _service.categories,
            ),
          ],
        ),
      ),
    );
  }
}
