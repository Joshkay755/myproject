import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

import '../firebase_service.dart';
import '../widgets/categories_list_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  static const String id = 'sub-category';
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  final FirebaseService _service = FirebaseService();
  final TextEditingController _subCatName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic image;
  String? fileName;
  Object? _selectedValue;
  bool _noCategorySelected = false;
  QuerySnapshot? snapshot;


  Widget _dropDownButton(){
    return DropdownButton(
        value: _selectedValue,
        hint: Text('Select Main Category'),
        items: snapshot!.docs.map((e) {
          return DropdownMenuItem<String>(
            value: e['mainCategory'],
            child: Text(e['mainCategory']),
          );
        }).toList(),
        onChanged: (selectedCat){
          setState(() {
            _selectedValue = selectedCat;
            _noCategorySelected = false;
          });
        });
  }


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
    var ref = FirebaseStorage.instance.ref('subCategoryImage/$fileName');
    try {
      String? mimiType = mime(basename(fileName!),);
      var metaData = SettableMetadata(contentType: mimiType);
      TaskSnapshot uploadSnapshot = await ref.putData(image,metaData);
      String downloadURL = await uploadSnapshot.ref.getDownloadURL().then((value) {
        if(value.isNotEmpty){
          _service.saveCategory(
              data: {
            'subCatName' : _subCatName.text,
            'mainCategory': _selectedValue,
            'image' : '$value.png',
            'active': true
          },
              docName: _subCatName.text,
              reference: _service.subCat
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
      _subCatName.clear();
      image = null;
    });
  }


  @override
  void initState() {
    getMainCatList();
    super.initState();
  }

  getMainCatList(){
    return _service.mainCat
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sub Categories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(color: Colors.grey,),

          Row(
            children:[
              const SizedBox(width: 10,),
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
                child: Center(child: image==null ? const Text('Sub Category Image'):Image.memory(image, fit: BoxFit.cover,),),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: pickImage,
                child:const Text('Upload Image'),
              )
            ],
            ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot==null ? const Text('loading...') :
                  _dropDownButton(),
                  SizedBox(height: 8,),
                  if(_noCategorySelected == true)
                    Text('No Main Category Selected', style: TextStyle(color: Colors.red),),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Sub Category Name';
                        }
                        return null;
                      },
                      controller: _subCatName,
                      decoration: const InputDecoration(
                          label: Text('Enter Sub Category Name'),
                          contentPadding: EdgeInsets.zero
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      TextButton(onPressed: clear,
                        child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor),),
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.white),
                            side: WidgetStateProperty.all(BorderSide(color: Theme.of(context).primaryColor),)
                        ),
                      ),
                      const SizedBox(width: 10,),
                      if(image!=null)
                      ElevatedButton(
                        onPressed: (){
                          if(_selectedValue==null){
                            setState(() {
                              _noCategorySelected = true;
                            });
                            return;
                          }
                          if(_formKey.currentState!.validate()){
                            saveImageToDb();
                          }
                        },
                        child: const Text('  Save  '),),
                    ],
                  ),
                ],
              ),
           ],
          ),
          const Divider(color: Colors.grey,),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sub Category List',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          CategoriesListWidget(
            reference: _service.subCat,
          ),
        ],
      ),
    );
  }
}
