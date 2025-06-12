import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zedeverything_vendor/firebase_services.dart';
import 'package:zedeverything_vendor/widget/products/product_card.dart';

import '../../model/product_model.dart';

class UnpublishedProduct extends StatelessWidget {
  const UnpublishedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return FirestoreQueryBuilder<Product>(
      query: productQuery(false),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return Center(child: const CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }
        if(snapshot.docs.isEmpty){
          return Center(child: Text('No Unpublished Products'),);
        }
        return ProductCard(snapshot: snapshot,);
      },
    );
  }
}


