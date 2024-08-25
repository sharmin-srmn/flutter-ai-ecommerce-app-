import 'package:final_project_shopping_app/common/widgets/success_screen/success_screen.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/address_controller.dart';
import 'package:final_project_shopping_app/features/shop/controllers/cart_controller.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:final_project_shopping_app/utils/constants/enums.dart';
import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:final_project_shopping_app/utils/popups/full_screen_loader.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/repositories/order/order_repository.dart';
import '../models/order_model.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  ///VARIABLES
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  //FETCH USER'S ORDER HISTORY
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  ///ADD METHOD FOR ORDER PROCESSING
  void processOrder(double totalAmount) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing youe order.', TImages.docerAnimation);
      //GET USER AUTHENTICATION ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final deliveryDate = DateTime.now().add(const Duration(days: 3));

      //ADD DETAILS
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        address: addressController.selectedAddress.value,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        deliveryDate: deliveryDate, // ADDRESS MODIFY KORTE HOEB
        items: cartController.cartItems.toList(),
      );

      //SAVE THE ORDER TO FIRE STORE
      await orderRepository.saveOrder(order, userId);

      //UPDATE THE CART STATUS
      cartController.clearCart();

      //SHOW SUCCESSCSREEN
      Get.off(() => SuccessScreen(
            image: TImages.orderConfirmed,
            title: 'Payment Success',
            subtitle: 'Your item will be shipped soon.',
            onPressed: () => Get.to(() => const NavigationMenu()),
          ));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
