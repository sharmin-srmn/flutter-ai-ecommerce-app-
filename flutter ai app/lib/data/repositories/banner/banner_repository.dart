import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/admin_dashboard/models/banner_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  ///VARIABLES
  final _db = FirebaseFirestore.instance;

  //UPLOAD ANY IMAGE IN THE FIREBASE STORAGE
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
      throw 'Something went wrong while uploading banner image. Please try again later.';
    }
  }

  ///FUNCTION TO SAVE BANNER DATA TO FIREBASE
  Future<void> saveBannerRecord(BannerModel banner) async {
    try {
      await _db.collection('Banners').doc().set(banner.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving banner record. Please try again later.';
    }
  }

  ///FUNCTION TO UPDATE BANNER DATA TO FIREBASE
  Future<void> updateBannerRecord(BannerModel banner) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('Banners')
          .where('Id', isEqualTo: banner.id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Update each document found
        for (QueryDocumentSnapshot<Map<String, dynamic>> document
            in querySnapshot.docs) {
          await document.reference.update({
            'ImageUrl': banner.imageUrl,
            'Active': banner.active,
            // Add more fields here if needed
          });
        }
      } else {
        throw 'Document not found for ID: ${banner.id}';
      }
      // await _db.collection('Banners').doc().set(banner.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving banner record. Please try again later.';
    }
  }

  ///FUNCTION TO FETCH ONLY FEATURED BANNER TO FIREBASE
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners . Please try again later.';
    }
  }

  ///FUNCTION TO FETCH ONLY FEATURED BANNER TO FIREBASE
  Future<List<BannerModel>> fetchAllBanners() async {
    try {
      final result = await _db.collection('Banners').get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners . Please try again later.';
    }
  }

  //DELETE THE BANNER IMAGE BEFORE
  Future<void> deleteBannerImage(String imageUrlToDelete) async {
    try {
      //DELETE THE IMAGE FROM FIREBASE STORAGE
      if (imageUrlToDelete.isNotEmpty) {
        // CREATE A REFERENCE TO THE IMAGE IN FIREBASE STORAGE
        final Reference imageRef =
            FirebaseStorage.instance.refFromURL(imageUrlToDelete);

        // DELETING THE IMAGE
        await imageRef.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting Banner Image. Please try again later.';
    }
  }

  //DELETE THE BANNER RECORD
  Future<void> deleteBannerRecord(String bannerId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('Banners')
          .where('Id', isEqualTo: bannerId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // GET THE DOCUMENT ID
        String documentId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('Banners')
            .doc(documentId)
            .delete();
      } else {
        throw 'Document with bannerId $bannerId not found.';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting banner record. Please try again later.';
    }
  }
}
