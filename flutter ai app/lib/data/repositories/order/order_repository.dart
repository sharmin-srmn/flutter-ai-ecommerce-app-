import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  //VARIAB:ES
  final _db = FirebaseFirestore.instance;

  //GET ALL ORDER RELATED TO CURRENT USER
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final authUser = AuthenticationRepository.instance.authUser;
      if (authUser == null) {
        throw 'Authentication information is null.';
      }

      final userId = authUser.uid;
      // print(userId);
      if (userId.isEmpty) throw 'Unable to find User Information.';

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Some thing went wrong while fetching order information. Try again later';
    }
  }

  //STORE NEW USERS ORDER
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information. Please try again later ';
    }
  }
}
