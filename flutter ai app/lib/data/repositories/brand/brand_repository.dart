import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //VARIABLES
  final _db = FirebaseFirestore.instance;

  //GET ALL BRAND
  Future<List<String>> getAllBrands() async {
    try {
      // Query the 'Products' collection
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('Products').get();

      // Create a Set to hold unique brand names
      Set<String> brandNames = {};

      // Iterate through each document and extract the brand name
      for (var doc in snapshot.docs) {
        String? brandName = doc.data()['Brand'] as String?;
        if (brandName != null && brandName.isNotEmpty) {
          brandNames.add(brandName.toLowerCase());
        }
      }

      // Convert the set of brand names to a list
      return brandNames.toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching brands. Please try again later.';
    }
  }

  // //GET ALL BRAND BY CATEGORY NAME
  // Future<List<String>> getBrandsByCategoryName(String categoryName) async {
  //   try {
  //     // Query the 'Products' collection
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //         await _db.collection('Products').get();

  //     // Create a Set to hold unique brand names
  //     Set<String> brandNames = {};

  //     // Iterate through each document
  //     for (var doc in snapshot.docs) {
  //       // Retrieve the 'tag' and 'Brand' fields
  //       String? tagString = doc.data()['Tag'] as String?;
  //       String? brandName = doc.data()['Brand'] as String?;

  //       // Ensure tagString and brandName are not null
  //       if (tagString != null && brandName != null) {
  //         // Split the tagString into a list of tags
  //         List<String> tags = tagString
  //             .split(',')
  //             .map((tag) => tag.trim().toLowerCase())
  //             .toList();

  //         // Check if the categoryName matches any of the tags
  //         if (tags.contains(categoryName.toLowerCase())) {
  //           brandNames.add(brandName);
  //         }
  //       }
  //     }

  //     // Convert the set of brand names to a list and return it
  //     return brandNames.toList();
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong while saving category. Please try again later.';
  //   }
  // }

  Future<List<Map<String, dynamic>>> getBrandsByCategoryName(
      String categoryName) async {
    try {
      // Query the 'Products' collection
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('Products').get();

      // Create a list to hold the result as maps
      List<Map<String, dynamic>> result = [];

      // Iterate through each document
      for (var doc in snapshot.docs) {
        // Retrieve the 'tag' and 'Brand' fields
        String? tagString = doc.data()['Tag'] as String?;
        String? brandName = doc.data()['Brand'] as String?;

        // Ensure tagString and brandName are not null
        if (tagString != null && brandName != null) {
          // Split the tagString into a list of tags
          List<String> tags = tagString
              .split(',')
              .map((tag) => tag.trim().toLowerCase())
              .toList();

          // Check if the categoryName matches any of the tags
          if (tags.contains(categoryName.toLowerCase())) {
            // Add a map to the list that holds the category name, brand name, and tag name
            result.add({
              'category': categoryName,
              'brand': brandName,
              'tag': tagString,
            });
          }
        }
      }

      // Return the list of maps
      return result;
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
}
