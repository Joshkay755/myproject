import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/Widgets/category/main_category_widget.dart';
import 'package:finalproject/models/category_model.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _title = 'Categories';
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          selectedCategory==null ? _title : selectedCategory!,
          style:const TextStyle(color: Colors.black, fontSize: 20),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        actions: [
          IconButton(
              icon: const Icon(IconlyLight.search),
            onPressed: (){
            },
          ),
          IconButton(
            icon: const Icon(IconlyLight.buy),
            onPressed: (){
            },
          ),
          IconButton(
            icon:const Icon(IconlyLight.moreSquare),
            onPressed: (){

            },
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 80,
            color: Colors.grey.shade400,
            child: FirestoreListView<Category>(
              query: categoryCollection,
              itemBuilder: (context, snapshot) {
                Category category = snapshot.data();
                return InkWell(
                  onTap: (){
                    setState(() {
                      _title= category.catName!;
                      selectedCategory = category.catName;
                    });
                  },
                  child: Container(
                    height: 90,
                    color: selectedCategory == category.catName ? Colors.white : Colors.grey.shade300,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 42,
                              child: CachedNetworkImage(
                                  imageUrl: category.image!,
                                color: selectedCategory == category.catName ? Theme.of(context).primaryColor:Colors.grey.shade800,
                              ),
                            ),
                            Text(category.catName!,
                              style: TextStyle(
                                  fontSize: 10,
                                color: selectedCategory == category.catName ? Theme.of(context).primaryColor:Colors.grey.shade800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          MainCategoryWidget(
            selectedCat: selectedCategory,
          )
        ],
      ),
    );
  }
}
