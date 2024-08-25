import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find the user information. Try again later.';
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Somerhing went wrong while fetching the address. Try again later.';
    }
  }

  // CLEAR THESELECTED FIELD FOR ALL ADDRESS
  Future<void> updateSelectedField(String adressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(adressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update Your address selection. Try again later';
    }
  }

  //STORE NEW ADDRESS
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving  Address information. Try again later.';
    }
  }
}
