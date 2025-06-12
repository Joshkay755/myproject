import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zedeverything_vendor/model/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;
  final String? productId;
  const ProductDetailsScreen({this.product, this.productId, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _formKey = GlobalKey();
  bool _editable = true;
  final _productName = TextEditingController();
  final _brand = TextEditingController();
  final _salesPrice = TextEditingController();
  final _regularPrice = TextEditingController();
  final _description = TextEditingController();
  final _soh = TextEditingController();
  final _reorderLevel = TextEditingController();
  final _deliveryCharge = TextEditingController();

  String? taxStatus;
  String? taxAmount;

  Widget _taxStatusDropDown(){
    return DropdownButtonFormField<String>(
      value: taxStatus,
      hint: const Text('Tax status', style: TextStyle(fontSize: 16),),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      onChanged: (String? newValue) {
        // This is called when the user selects an item.
        setState(() {
          taxStatus = newValue!;
        });
      },
      items: ['Taxable','Non Taxable'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      validator: (value){
        if(value!.isEmpty){
          return 'Select tax status';
        }
        return null;
      },
    );
  }
  Widget _taxAmount(){
    return DropdownButtonFormField<String>(
      value: taxAmount,
      hint: const Text('Tax amount', style: TextStyle(fontSize: 16),),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      onChanged: (String? newValue) {
        // This is called when the user selects an item.
        setState(() {
          taxAmount = newValue!;
        });
      },
      items: ['GST-10%','GST-12%'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      validator: (value){
        if(value!.isEmpty){
          return 'Select tax amount';
        }
        return null;
      },
    );
  }

Widget _textField({TextEditingController? controller, String? label, TextInputType? inputType}){
    return TextFormField(
      controller: controller,
      keyboardType:inputType ,
      validator: (value){
        if(value!.isEmpty){
          return 'enter $label';
        }
        return null;
      },
    );
}


  @override
  void initState() {
    setState(() {
      _productName.text= widget.product!.productName!;
      _brand.text=widget.product!.brand!;
      _salesPrice.text=widget.product!.salesPrice!.toString();
      _regularPrice.text=widget.product!.regularPrice!.toString();
      taxStatus = widget.product!.taxStatus;
      taxAmount = widget.product!.taxValue==10 ? 'GST-10%':'GST-12%';
      _soh.text = widget.product!.soh!.toString();
      _reorderLevel.text = widget.product!.reOrderLevel!.toString();
      _deliveryCharge.text = widget.product!.deliveryCharge!.toString();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.product!.productName!),
          actions: [
            _editable ?
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: (){
                setState(() {
                  _editable = false;
                });
              },
            ) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blueGrey)
                ),
                  child: Text('Save'),
                onPressed: (){
                    setState(() {
                      _editable = true;
                    });
                },),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              AbsorbPointer(
                absorbing: _editable,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.product!.imageUrls!.map((e){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CachedNetworkImage(imageUrl: e),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Brand : ',style: TextStyle(color: Colors.grey.shade700),),
                        SizedBox(width: 10,),
                        Expanded(
                          child: _textField(
                            label: 'Brand',
                            inputType: TextInputType.text,
                            controller:_brand,
                          ),
                        ),
                      ],
                    ),
                    _textField(
                      label: 'Product name',
                      inputType: TextInputType.text,
                      controller:_productName,
                    ),
                    _textField(
                      label: 'Description',
                      inputType: TextInputType.text,
                      controller:_description,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 10),
                      child: Row(
                        children: [
                          Text('Unit : '),
                          Text(widget.product!.unit!),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if(widget.product!.salesPrice!=null)
                          Expanded(
                            child: Row(
                              children: [
                                Text('Sales price : ',style: TextStyle(color: Colors.grey.shade700),),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: _textField(
                                    label: 'Sales price',
                                    inputType: TextInputType.number,
                                    controller:_salesPrice,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('Regular price : ',style: TextStyle(color: Colors.grey.shade700),),
                              SizedBox(width: 8,),
                              Expanded(
                                child: _textField(
                                  label: 'Regular price',
                                  inputType: TextInputType.number,
                                  controller:_regularPrice,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _taxStatusDropDown()),
                        SizedBox(width: 10,),
                        if(taxStatus == 'Taxable')
                          Expanded(child: _taxAmount(),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Text('Category : ',style: TextStyle(color: Colors.grey.shade700),),
                          SizedBox(width: 10,),
                          Text(widget.product!.category!),
                        ],
                      ),
                    ),
                    if(widget.product!.mainCategory!=null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text('Main category : ',style: TextStyle(color: Colors.grey.shade700),),
                            SizedBox(width: 10,),
                            Text(widget.product!.mainCategory!),
                          ],
                        ),
                      ),
                    if(widget.product!.subCategory!=null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text('Sub category : ',style: TextStyle(color: Colors.grey.shade700),),
                            SizedBox(width: 10,),
                            Text(widget.product!.subCategory!),
                          ],
                        ),
                      ),

                    SizedBox(width: 10,),
                    if(widget.product!.manageInventory==true)
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text('SOH : ',style: TextStyle(color: Colors.grey.shade700),),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: _textField(
                                    label: 'SOH',
                                    inputType: TextInputType.number,
                                    controller:_soh,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text('Reorder Level : ',style: TextStyle(color: Colors.grey.shade700),),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: _textField(
                                    label: 'Re-order Level',
                                    inputType: TextInputType.number,
                                    controller:_reorderLevel,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    if(widget.product!.chargeDelivery == true)
                      Row(
                        children: [
                          Text('Shipping charge :'),
                          Expanded(child: _textField(
                              label: 'Delivery charge',
                              inputType: TextInputType.number,
                              controller: _deliveryCharge
                          ),)
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10,),
                      child: Row(
                        children: [
                          Text("SKU :",style: TextStyle(color: Colors.grey),),
                          Text(widget.product!.sku!),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
