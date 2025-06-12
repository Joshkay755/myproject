import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject_admin/firebase_service.dart';
import 'package:flutter/material.dart';

class CategoriesListWidget extends StatefulWidget {
  final CollectionReference? reference;
  const CategoriesListWidget({super.key, this.reference});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  final FirebaseService service = FirebaseService();
  Object? _selectedValue;
  QuerySnapshot? snapshot;

  Widget categoryWidget(data){
    return Card(
      color: Colors.grey.shade500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20,),
            SizedBox(
                height: 80,
                width: 80,
                child: Image.network(data['image'])),
            Text(widget.reference == service.categories ? data['catName']:data['subCatName']),
          ],
        ),
      ),
    );
  }

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
          });
        });
  }

  @override
  void initState() {
    getMainCatList();
    super.initState();
  }

  getMainCatList(){
    return service.mainCat
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        snapshot = querySnapshot;
      });
    });
  }


  @override
  Widget build(BuildContext context) {



    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         if(widget.reference == service.subCat &&  snapshot!=null)
            Row(
              children: [
                _dropDownButton(),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _selectedValue = null;
                  });
                }, child: Text('Show All'))
              ],
            ),
          const SizedBox(height:  10,),
          StreamBuilder<QuerySnapshot>(
            stream: widget.reference!.where('mainCategory',isEqualTo: _selectedValue).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }

              if(snapshot.data!.size==0){
                return const Text('No Categories Added');
              }

              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context,index){
                    var data = snapshot.data!.docs[index];
                    return categoryWidget(data);
                  },);
            },
          ),
        ],
      ),
    );
  }
}
