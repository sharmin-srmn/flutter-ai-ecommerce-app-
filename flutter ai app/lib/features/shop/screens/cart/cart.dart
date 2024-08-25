import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/loaders/animation_loader.dart';
import 'package:final_project_shopping_app/features/shop/controllers/cart_controller.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(
        () {
          //NOTHING FOUND ANIMATION

          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Cart is Empty',
            animation: TImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.offAll(() => const NavigationMenu()),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),

              ///Items in Cart
              child: TCartItems(),
            );
          }
        },
      ),

      ///Checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Obx(
              () => Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    () => const CheckoutScreen(),
                  ),
                  child:
                      Text('Checkout BDT ${controller.totalCartPrice.value} '),
                ),
              ),
            ),
    );
  }
}
