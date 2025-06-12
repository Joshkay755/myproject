import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zedeverything_vendor/provider/product_provider.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({super.key});

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab>with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive=>true;


  final ImagePicker picker = ImagePicker();



  Future<List<XFile>?>_pickImage()async{
    final List<XFile>? images = await picker.pickMultiImage();
    return images;
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(
        builder: (context,provider,_){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                TextButton(
                  child: Text('Add Product Image') ,
                  onPressed: (){
                    _pickImage().then((value){
                      var list = value!.forEach((image){
                        setState(() {
                          provider.imageFiles!.add(image);
                        });
                      });
                    });
                  }, ),
                Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: provider.imageFiles!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onLongPress: (){
                                setState(() {
                                  provider.imageFiles!.removeAt(index);
                                });
                              },
                              child: provider.imageFiles==null ? Center(child: Text('No Images Selected'),):
                              Image.file(File(provider.imageFiles![index].path))),
                        );
                      },
                    )
                )
              ],
            ),
          );
        });
  }
}
