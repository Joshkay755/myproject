
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/models/sub_category_model.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoryWidget extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategoryWidget({ this.selectedSubCat, super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<SubCategory>(
      query: subCategoryCollection(
        selectedSubCat: selectedSubCat
      ),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: snapshot.docs.length==0 ? .1 : 1/1.1
          ),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {

            SubCategory subCat = snapshot.docs[index].data();
            return InkWell(
              onTap: (){

              },
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: FittedBox(
                      fit: BoxFit.contain,
                        child: CachedNetworkImage(
                            imageUrl: subCat.image!,
                          placeholder: (context,_){
                              return Container(
                                height: 70,
                                width:70,
                                color: Colors.grey.shade300,
                              );
                          },

                        ),
                    ),
                  ),
                  Text(subCat.subCatName!,style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
