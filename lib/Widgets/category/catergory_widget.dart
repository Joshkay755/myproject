import 'package:finalproject/screens/main_screen.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../models/category_model.dart';

class CatergoryWidget extends StatefulWidget {
  const CatergoryWidget({super.key});

  @override
  State<CatergoryWidget> createState() => _CatergoryWidgetState();
}

class _CatergoryWidgetState extends State<CatergoryWidget> {

 String? _selectedCategory;


  @override
  Widget build(BuildContext context) {





    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 18,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child:  Text('Stores For You',
                style: TextStyle(fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child:
                    FirestoreListView<Category>(
                      scrollDirection: Axis.horizontal,
                      query: categoryCollection,
                      itemBuilder: (context, snapshot) {
                        Category category = snapshot.data();
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: ActionChip(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)
                            ),
                            backgroundColor: _selectedCategory == category.catName ? Colors.blue.shade900 : Colors.grey,
                            label: Text(
                              category.catName!,
                              style: TextStyle(
                                  fontSize: 12, color: _selectedCategory==category.catName ? Colors.white : Colors.black),
                            ),
                            onPressed: (){
                              setState(() {
                                _selectedCategory = category.catName;
                              });
                            },
                          ),
                        );
                      },
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey.shade500))
                    ),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => const MainScreen(
                                  index: 1,
                                )
                            )
                        );
                      },
                      icon: Icon(IconlyLight.arrowDown),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
