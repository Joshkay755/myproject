import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zedeverything_vendor/firebase_services.dart';
import 'package:zedeverything_vendor/provider/vendor_provider.dart';
import 'package:zedeverything_vendor/widget/add_product/attribute_tab.dart';
import 'package:zedeverything_vendor/widget/add_product/delivery_tab.dart';
import 'package:zedeverything_vendor/widget/add_product/general_tab.dart';
import 'package:zedeverything_vendor/widget/add_product/image_tab.dart';
import 'package:zedeverything_vendor/widget/add_product/inventory_tab.dart';

import '../provider/product_provider.dart';
import '../widget/custom_drawer.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = 'add-product-screen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductProvider>(context);
    final _vendor = Provider.of<VendorProvider>(context);
    final _formKey = GlobalKey<FormState>();
    FirebaseServices _services = FirebaseServices();
    return Form(
      key:_formKey ,
      child: DefaultTabController(
        length: 6,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Add New Product', ),
            elevation: 0,
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4,
                    color: Colors.white54,
                  )
                ),
                tabs: [
                  Tab(
                    child: Text('General'),
                  ),
                  Tab(
                    child: Text('Inventory'),
                  ),
                  Tab(
                    child: Text('Delivery'),
                  ),
                  Tab(
                    child: Text('Attributes'),
                  ),
                  Tab(
                    child: Text('Linked Products'),
                  ),
                  Tab(
                    child: Text('Images'),
                  ),
                ]),
          ),
          drawer: const CustomDrawer(),
          body: TabBarView(
            children:[
              GeneralTab(),
              InventoryTab(),
              DeliveryTab(),
              AttributeTab(),
              Center(child: Text('Link Pro Tab')),
              ImageTab(),
            ]
          ),
          persistentFooterButtons: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text('Save Product'),
                    onPressed: (){
                      if(_provider.imageFiles!.isEmpty){
                        _services.scaffold(context, 'Image not Selected');
                        return;
                      }
                      if(_formKey.currentState!.validate()){
                        EasyLoading.show(status: 'Please wait..');
                        _provider.getFormData(
                          seller: {
                            'name':_vendor.vendor!.businessName,
                            'uid':_services.user!.uid,
                          }
                        );
                        _services.uploadFiles(
                          images: _provider.imageFiles,
                          ref: 'products/${_vendor.vendor!.businessName}/${_provider.productData!['productName']}',
                          provider: _provider,
                        ).then((value){
                          if(value.isNotEmpty){
                            _services.saveToDb(
                              data: _provider.productData!,
                              context: context
                            ).then((value){
                              EasyLoading.dismiss();
                              setState((){
                                _provider.clearProductData();
                              });
                            });
                          }
                        });
                      }
                    },),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
