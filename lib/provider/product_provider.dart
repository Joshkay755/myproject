import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider with ChangeNotifier{

 Map<String,dynamic>? productData={
   'approved':false
 };
 final List<XFile>? imageFiles = [];

  getFormData({
    String? productName,
    int? regularPrice,
    int? salesPrice,
    String? taxStatus,
    double? taxPercentage,
    String? category,
    String? mainCategory,
    String? subCategory,
    String? description,
    DateTime? scheduleDate,
    String? sku,
    bool? manageInventory,
    int? soh,
    int? reOrderLevel,
    bool? chargeDelivery,
    int? deliveryCharge,
    String? brand,
    List? sizeList,
    String? otherDetails,
    String? unit,
    List? imageUrls,
    Map? seller,
  }){
    if(seller!=null){
      productData!['seller'] = seller;
    }
    if(productName!=null){
      productData!['productName'] = productName;
    }
    if(regularPrice!=null){
      productData!['regularPrice'] = regularPrice;
    }
    if(salesPrice!=null){
      productData!['salesPrice'] = salesPrice;
    }
    if(taxStatus!=null){
      productData!['taxStatus'] = taxStatus;
    }
    if(taxPercentage!=null){
      productData!['taxValue'] = taxPercentage;
    }
    if(category!=null){
      productData!['category'] = category;
    }
    if(mainCategory!=null){
      productData!['mainCategory'] = mainCategory;
    }
    if(subCategory!=null){
      productData!['subCategory'] = subCategory;
    }
    if(description!=null){
      productData!['description'] = description;
    }
    if(scheduleDate!=null){
      productData!['scheduleDate'] = scheduleDate;
    }
    if(sku!=null){
      productData!['sku'] = sku;
    }
    if(manageInventory!=null){
      productData!['manageInventory'] = manageInventory;
    }
    if(soh!=null){
      productData!['soh'] = soh;
    }
    if(reOrderLevel!=null){
      productData!['reOrderLevel'] = reOrderLevel;
    }
    if(chargeDelivery!=null){
      productData!['chargeDelivery'] = chargeDelivery;
    }
    if(deliveryCharge!=null){
      productData!['deliveryCharge'] = deliveryCharge;
    }
    if(brand!=null){
      productData!['brand'] = brand;
    }
    if(sizeList!=null){
      productData!['sizeList'] = sizeList;
    }
    if(otherDetails!=null){
      productData!['otherDetails'] = otherDetails;
    }
    if(unit!=null){
      productData!['unit'] = unit;
    }
    if(imageUrls!=null){
      productData!['imageUrls'] = imageUrls;
    }
    notifyListeners();
  }
  getImageFile(image){
    imageFiles!.add(image);
    notifyListeners();
  }

  clearProductData(){
    productData!.clear();
    imageFiles!.clear();
    productData!['approved']=false;
    notifyListeners();
  }
}