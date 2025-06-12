import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zedeverything_vendor/widget/products/product_details_screen.dart';

import '../../firebase_services.dart';
import '../../model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, this.snapshot});
  final FirestoreQueryBuilderSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: snapshot!.docs.length,
        itemBuilder: (context, index) {
          Product product = snapshot!.docs[index].data();
          String id = snapshot!.docs[index].id;
          var discount =
              (product.regularPrice! - product.salesPrice!) /
                  product.regularPrice! *
                  100;
          return Slidable(
            endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    onPressed: (context){

                    },
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline_outlined,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    flex: 1,
                    onPressed: (context){
                      services.product.doc(id).update({
                        'approved':product.approved==false ? true : false
                      });
                    },
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    icon: Icons.check_circle_outline_sharp,
                    label: product.approved==false ?'Approve' : 'Inactive',
                  ),
                ]),
            child: InkWell(
              onTap: (){
                Navigator.push (
                  context,
                  MaterialPageRoute (
                    builder: (BuildContext context) => ProductDetailsScreen(
                      product: product,
                      productId: id,
                    ),
                  ),
                );
              },
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrls![0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.productName!),
                          Row(
                            children: [
                              if (product.salesPrice != null)
                                Text(
                                  services.formattedNumber(
                                    product.salesPrice,
                                  ),
                                ),
                              SizedBox(width: 10),
                              Text(
                                services.formattedNumber(
                                  product.regularPrice,
                                ),
                                style: TextStyle(
                                  decoration: product.salesPrice != null
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${discount.toInt()}%',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}