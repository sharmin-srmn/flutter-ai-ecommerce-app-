import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  String tag;
  List<String> brand;

  CategoryModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.isFeatured,
      this.parentId = '',
      this.brand = const [],
      this.tag = ''});

  ///EMPTY HELPER FUNCTION
  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

  ///CONVERTING MODEL TO JSON STRUCTURE SO THAT WE CAN STORE DATA IS FIREBASE
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentID': parentId,
      'IsFeatured': isFeatured,
      'Brand': brand,
      'Tag': tag
    };
  }

  ///MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE TO MODEL
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //MAP JSON RECOD TO THE MODEL
      return CategoryModel(
        id: document.id,
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        parentId: data['ParentID'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        tag: data['Tag'] ?? '',
        brand: List<String>.from(data['Brand'] ?? []),
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
