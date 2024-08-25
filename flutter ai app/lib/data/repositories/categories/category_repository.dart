import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/features/shop/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///VARIABLES
  final _db = FirebaseFirestore.instance;

  ///FUNCTION TO CATEGORY  DATA TO FIREBASE
  Future<void> saveCategoryRecord(CategoryModel category) async {
    try {
      await _db.collection('Categories').doc().set(category.toJson());
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

  ///FUNCTION TO UPDATE CATEGORY  DATA TO FIREBASE
  Future<void> updateCategoryRecord(CategoryModel category) async {
    try {
      await _db
          .collection('Categories')
          .doc(category.id)
          .update(category.toJson());
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

  ///GET ALL CATEGORIES
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while getting all categories. Please try again later.';
    }
  }

  //UPLOAD ANY IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      // final ref = FirebaseStorage.instance.ref(path).child(image.name);
      // await ref.putFile(File(image.path));
      // final url = await ref.getDownloadURL();
      // return url;
      final timestamp =
          DateTime.now().millisecondsSinceEpoch; // Generate a timestamp
      final uniqueFilename =
          '$timestamp-${image.name}'; // Append timestamp to the filename

      final ref = FirebaseStorage.instance.ref(path).child(uniqueFilename);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while uploading category image. Please try again later.';
    }
  }

  //DELETE IMAGE FROM STORAGE BEFORE DELETING THE RECORD FROM FIRESTORE BATABASE
  Future<void> deleteCategoryImage(String imageUrlToDelete) async {
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
      throw 'Something went wrong while deleting Category Image. Please try again later.';
    }
  }

  //DELETE THE BANNER IMAGE
  Future<void> deleteCategoryRecord(String categoryName) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('Categories')
          .where('Name', isEqualTo: categoryName)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting Product record. Please try again later.';
    }
  }

  ///GET SUB CATEGORIES
  ///UOLOAD CATEGORIES TO THE CLOUD FIRESTORE
  // Future<void> uploadDummyData(List<CategoryModel> categories) async {
  //   try {
  //     //UPLOAD ALL THE CATEGORIES ALONG WITH THEIR IMAGES
  //     final storage = Get.put(TFirebaseStorageService());

  //     //LOAD THROUGH EACH CATEGORY
  //     for (var category in categories) {
  //       // GET IMAGE DATA LINK FROM LOCAL ASSETS
  //       final file = await storage.getImageDataFromAssets(category.image);

  //       //UPLOAD IMAGE AND GET ITS URL
  //       final url =
  //           await storage.uploadImageData('Categories', file, category.name);

  //       //ASSIGN URL TO CATERORY>IMAGE ATTRIBUTE
  //       category.image = url;

  //       //STORE CATEGORY IN FIRESTORE
  //       await _db
  //           .collection('Categories')
  //           .doc(category.id)
  //           .set(category.toJson());
  //     }
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again later.';
  //   }
  // }
}
