import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;
  const EditProductScreen({Key? key, required this.productId, required this.productData}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  late double price;

  @override
  void initState() {
    super.initState();
    name = widget.productData['name'] ?? '';
    description = widget.productData['description'] ?? '';
    price = widget.productData['price']?.toDouble() ?? 0.0;
  }

  Future<void> saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({
        'name': name,
        'description': description,
        'price': price,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product updated!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (val) => description = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => price = double.tryParse(val ?? '0') ?? 0.0,
                validator: (val) => val == null || double.tryParse(val) == null ? 'Invalid price' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProduct,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}