import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //GET FEATURED (TRUE) PRODUCTS LIMITED PRODUCTS
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching featured products. Please try again laterrrr.';
    }
  }

  //GET ALL FEATURED PRODUCTS
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching featured products. Please try again laterrrr.';
    }
  }

  //GET ALL  PRODUCTS
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot =
          await _db.collection('Products').orderBy('ProductId').get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching all products. Please try again laterrrr.';
    }
  }

  //GET FEATURED (TRUE) PRODUCTS LIMITED PRODUCTS
  Future<List<ProductModel>> getProductsSimilarToImage(
      List<String> productIds) async {
    try {
      List<ProductModel> products = [];

      // Convert string IDs to integer IDs
      List<int> intProductIds = productIds.map(int.parse).toList();

      // Fetch products one by one in the order specified by productIds
      for (int id in intProductIds) {
        final snapshot = await FirebaseFirestore.instance
            .collection('Products')
            .where('ProductId', isEqualTo: id)
            .limit(1) // Limit to 1 document
            .get();

        // If document is found, add it to the list
        if (snapshot.docs.isNotEmpty) {
          products.add(ProductModel.fromSnapshot(snapshot.docs.first));
        }
      }

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching featured products. Please try again laterrrr.';
    }
  }

  //GET PRODUCTS BY TAGNAME
  Future<List<ProductModel>> getProductsByTagName(String tagName) async {
    try {
      //GETTING ALL THE PRODUCTS
      final snapshot = await _db.collection('Products').get();

      // MAP THE SNAPSJOT DOCUEMNTS TO PRODUCTMODEL INSTANCES
      final allProducts =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      // FILTER THEPRODUCTS WHICH CONTAINS "men" TAG
      List<ProductModel> tagNameProducts = allProducts.where((product) {
        // SPLIT THE TAG FIELD BY COMMAS
        List<String> tags = product.tag.split(',');

        // TRIM THE WHITESPACE AND CONVERT THE TAGS TO LOWERCASE
        List<String> trimmedTags =
            tags.map((tag) => tag.trim().toLowerCase()).toList();

        // CHEK IF "men" EXACTLY MATCHS ANY OF THE TRIMMED TAGS
        return trimmedTags.contains(tagName.toLowerCase());
      }).toList();

      // RETURN THE FILTERED LIST OF MEN'S PRODUCTS
      return tagNameProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching $tagName related products. Please try again laterrrr.';
    }
  }

  //GET ALL BRAND RELATED PRODUCTS
  Future<List<ProductModel>> getProductsByBrandName(String brandName) async {
    try {
      //GETTING ALL THE PRODUCTS
      final snapshot = await _db.collection('Products').get();

      final filteredBrandProducts = snapshot.docs
          .map((e) => ProductModel.fromSnapshot(e))
          .where((product) {
        return product.brand.toLowerCase() == brandName.toLowerCase();
      }).toList();

      // RETURN THE PRODUCTS
      return filteredBrandProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving category. Please try again later.';
    }
  }

  //GET MENS  PRODUCTS
  Future<List<ProductModel>> getAllMensProducts() async {
    try {
      //GETTING ALL THE PRODUCTS
      final snapshot = await _db.collection('Products').get();

      // MAP THE SNAPSJOT DOCUEMNTS TO PRODUCTMODEL INSTANCES
      final allProducts =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      // FILTER THEPRODUCTS WHICH CONTAINS "men" TAG
      List<ProductModel> mensProducts = allProducts.where((product) {
        // SPLIT THE TAG FIELD BY COMMAS
        List<String> tags = product.tag.split(',');

        // TRIM THE WHITESPACE AND CONVERT THE TAGS TO LOWERCASE
        List<String> trimmedTags =
            tags.map((tag) => tag.trim().toLowerCase()).toList();

        // CHEK IF "men" EXACTLY MATCHS ANY OF THE TRIMMED TAGS
        return trimmedTags.contains('men');
      }).toList();

      // RETURN THE FILTERED LIST OF MEN'S PRODUCTS
      return mensProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching men\'s products. Please try again laterrrr.';
    }
  }

  //GET ALL WOMENS  PRODUCTS
  Future<List<ProductModel>> getAllWomensProducts() async {
    try {
      //GETTING ALL THE PRODUCTS
      final snapshot = await _db.collection('Products').get();

      // MAP THE SNAPSJOT DOCUEMNTS TO PRODUCTMODEL INSTANCES
      final allProducts =
          snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      // FILTER THEPRODUCTS WHICH CONTAINS "women" TAG
      List<ProductModel> womensProducts = allProducts.where((product) {
        // SPLIT THE TAG FIELD BY COMMAS
        List<String> tags = product.tag.split(',');

        // TRIM THE WHITESPACE AND CONVERT THE TAGS TO LOWERCASE
        List<String> trimmedTags =
            tags.map((tag) => tag.trim().toLowerCase()).toList();

        // CHEK IF "women" EXACTLY MATCHS ANY OF THE TRIMMED TAGS
        return trimmedTags.contains('women');
      }).toList();

      //SORTTING THEM
      womensProducts.sort((a, b) => a.date!.compareTo(b.date!));

      // RETURN THE FILTERED LIST OF WOMEN'S PRODUCTS
      return womensProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching men\'s products. Please try again laterrrr.';
    }
  }

  //GET ALL PRODUCTS BY QUERY
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productsList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productsList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching all products. Please try again laterrrr.';
    }
  }

  //GET FAVOURITE PRODUCTS BY QUERY
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching all products. Please try again laterrrr.';
    }
  }

  //GET ALL NEW ARRIVALS PRODUCTS
  Future<List<ProductModel>> getAllNewProducts() async {
    try {
      DateTime now = DateTime.now();
      DateTime timeThreshold = now.subtract(const Duration(days: 3));

      // Fetch products uploaded within the last 30 days
      final snapshot = await _db
          .collection('Products')
          .where('Date', isGreaterThanOrEqualTo: timeThreshold)
          .orderBy('Date', descending: true)
          .get();

      // Map the documents to ProductModel objects
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching new products. Please try again later.';
    }
  }

  //UPLOAD  IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final timestamp =
          DateTime.now().millisecondsSinceEpoch; // Generate a timestamp
      final uniqueFilename =
          '$timestamp-${image.name}'; // Append timestamp to the filename

      final ref = FirebaseStorage.instance.ref(path).child(uniqueFilename);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
      // final ref = FirebaseStorage.instance.ref(path).child(image.name);
      // await ref.putFile(File(image.path));
      // final url = await ref.getDownloadURL();
      // return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while uploading product image. Please try again later.';
    }
  }

  ///FUNCTION TO PRODUCT  DATA TO FIREBASE
  Future<void> saveProductRecord(ProductModel product) async {
    try {
      await _db.collection('Products').doc().set(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving product record. Please try again later.';
    }
  }

  ///FUNCTION TO UPDATE PRODUCT DATA TO FIREBASE
  Future<void> updateProductRecord(ProductModel product) async {
    try {
      //PRODUCT DOCUMNET ID
      // print('PRODUCT id = ${product.id}');
      await _db.collection('Products').doc(product.id).update({
        'Title': product.title,
        'ProductId': product.productId,
        'Description': product.description,
        'Brand': product.brand,
        'Category': product.category,
        'Tag': product.tag,
        'Stock': product.stock,
        'Price': product.price,
        'SalePrice': product.salePrice,
        'IsFeatured': product.isFeatured,
        'Image': product.image,
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while updating product record. Please try again later.';
    }
  }

  //DELETE IMAGE FROM STORAGE BEFORE DELETING THE RECORD FROM FIRESTORE BATABASE
  Future<void> deleteProductImage(String imageUrlToDelete) async {
    try {
      //DELETE THE IMAGE FROM FIREBASE STORAGE
      if (imageUrlToDelete.isNotEmpty) {
        // CREATE A REFERENCE TO THE IMAGE IN FIREBASE STORAGE
        final Reference imageRef =
            FirebaseStorage.instance.refFromURL(imageUrlToDelete);

        // DELETING THE IMAGE
        // await imageRef.delete();
        try {
          await imageRef.delete();
        } on FirebaseException catch (e) {
          // If the image doesn't exist in storage, it will throw an exception.
          // In that case, we do nothing, proceed to delete the product record.
          if (e.code == 'object-not-found') {
            return;
          } else {
            throw TFirebaseException(e.code).message;
          }
        }
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting Product Image. Please try again later.';
    }
  }

  //DELETE THE BANNER IMAGE
  Future<void> deleteProductRecord(String productId) async {
    try {
      await _db.collection('Products').doc(productId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting Product record. Please try again later.';
    }
  }
}
