import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zedeverything_vendor/widget/products/product_card.dart';

import '../../model/product_model.dart';

class PublishedProduct extends StatelessWidget {
  const PublishedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      query: productQuery(true),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return Center(child: const CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }
        if(snapshot.docs.isEmpty){
          return Center(child: Text('No Product Published Yet'),);
        }
        return ProductCard(snapshot: snapshot,);
      },
    );
  }
}
