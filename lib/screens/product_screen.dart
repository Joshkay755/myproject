import 'package:flutter/material.dart';
import 'package:zedeverything_vendor/widget/custom_drawer.dart';
import 'package:zedeverything_vendor/widget/products/published_product.dart';
import 'package:zedeverything_vendor/widget/products/unpublished.dart';

class ProductScreen extends StatelessWidget {
  static const String id = 'product-screen';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Product List'),
          elevation: 0,
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 6,
                color: Colors.white54
              )
            ),
            tabs: [
              Tab(child: Text('Unpublished',style: TextStyle(color:Colors.black87,))),
              Tab(child: Text('Published',style: TextStyle(color:Colors.black87,))),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
            children: [
              UnpublishedProduct(),
              PublishedProduct(),
        ],
        ),
      ),
    );
  }
}
