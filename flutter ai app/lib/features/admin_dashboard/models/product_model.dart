import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductModel {
  String id;
  int productId;
  String title;
  String description;
  String brand;
  String category;
  String tag;
  double price;
  double salePrice;
  int stock;
  bool isFeatured;
  String image;
  DateTime? date;

  ProductModel({
    required this.id,
    required this.productId,
    required this.isFeatured,
    required this.brand,
    required this.tag,
    required this.category,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.title,
    required this.description,
    required this.stock,
    this.date,
  });

  ///EMPTY HELPER FUNCTION
  static ProductModel empty() => ProductModel(
      id: '',
      productId: 0,
      isFeatured: false,
      brand: '',
      tag: '',
      category: '',
      price: 0,
      salePrice: 0,
      image: '',
      title: '',
      description: '',
      stock: 0,
      date: DateTime.now());

  ///CONVERTING MODEL TO JSON STRUCTURE SO THAT WE CAN STORE DATA IS FIREBASE
  Map<String, dynamic> toJson() {
    return {
      'Title': title.capitalize,
      'ProductId': productId,
      'Description': description.capitalize,
      'Brand': brand.capitalize,
      'Category': category.capitalize,
      'Tag': tag,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'Image': image,
      'IsFeatured': isFeatured,
      'Date': date,
    };
  }

  ///MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE TO MODEL
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // CONVERTING DATE FILE IN TO DATE
      DateTime? date;
      if (data['Date'] != null) {
        Timestamp timestamp = data['Date'];
        date = timestamp.toDate();
        // String formattedDate = DateFormat.yMd().format(date);
        // date = DateFormat.yMd().parse(formattedDate);
      }
      // Map JSON record to the model
      return ProductModel(
        id: document.id,
        image: data['Image'] ?? '',
        tag: data['Tag'] ?? '',
        brand: data['Brand'] ?? '',
        category: data['Category'] ?? '',
        price: double.parse((data['Price'] ?? 0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0).toString()),
        stock: int.parse((data['Stock'] ?? 0).toString()),
        description: data['Description'] ?? '',
        title: data['Title'] ?? '',
        productId: int.parse((data['ProductId'] ?? 0).toString()),
        isFeatured: data['IsFeatured'] ?? false,
        date: date ??
            DateTime.now(), // USE CONVERTED DATE OR DEFAULT TO CURRENT DATE
      );
    } else {
      return ProductModel.empty();
    }
  }

  ///MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE TO MODEL
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    // CONVERTING DATE FILE IN TO DATE
    DateTime? date;
    if (data['Date'] != null) {
      Timestamp timestamp = data['Date'];
      date = timestamp.toDate();
      // String formattedDate = DateFormat.yMMMd().format(date);
      String formattedDate = DateFormat.yMd().format(date);
      // date = DateFormat('d MMM, yyyy').parse(formattedDate);
      date = DateFormat.yMd().parse(formattedDate);
    }

    //MAP JSON RECORD TO THE MODEL
    return ProductModel(
      id: document.id,
      image: data['Image'] ?? '',
      tag: data['Tag'] ?? '',
      brand: data['Brand'] ?? '',
      category: data['Category'] ?? '',
      price: double.parse((data['Price'] ?? 0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0).toString()),
      stock: int.parse((data['Stock'] ?? 0).toString()),
      description: data['Description'] ?? '',
      title: data['Title'] ?? '',
      productId: int.parse((data['ProductId'] ?? 0).toString()),
      isFeatured: data['IsFeatured'] ?? false,
      date: date ??
          DateTime.now(), // Use converted date or default to current date
    );
  }
}
