import 'package:finalproject/firebase_service.dart';

class MainCategory {

  MainCategory({this.category, this.mainCategory});
  MainCategory.fromJson(Map<String, Object?> json)
      : this(
    category: json['category']! as String,
    mainCategory: json['mainCategory']! as String,
  );

  final String? category;
  final String? mainCategory;

  Map<String, Object?> toJson() {
    return {
      'category': category,
      'mainCategory': mainCategory,
    };
  }



}
FirebaseService service = FirebaseService();
mainCategoryCollection (selectedCat){
  return service.mainCategories.where('approved',isEqualTo: true).where('category',isEqualTo: selectedCat).withConverter<MainCategory>(
      fromFirestore: (snapshot, _) => MainCategory.fromJson(snapshot.data()!),
  toFirestore: (movie, _) => movie.toJson(),);
}