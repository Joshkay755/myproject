import 'package:finalproject/Widgets/category/sub_category_widget.dart';
import 'package:finalproject/models/main_category_model.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class MainCategoryWidget extends StatefulWidget {
  final String? selectedCat;
  const MainCategoryWidget({ this.selectedCat, super.key});

  @override
  State<MainCategoryWidget> createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategory>(
        query: mainCategoryCollection(widget.selectedCat),
        itemBuilder: (context, snapshot) {
          MainCategory mainCategory = snapshot.data();
          return ExpansionTile(
            title: Text(
                mainCategory.mainCategory!
            ),
            children: [
            SubCategoryWidget(
              selectedSubCat: mainCategory.mainCategory,
            )
          ],
          );
        },
      ),
    );
  }
}
