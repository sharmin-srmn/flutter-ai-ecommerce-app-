import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart_controller.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(
          () {
            final item = controller.cartItems[index];
            return Column(
              children: [
                ///cart item
                TCartItem(
                  cartItem: item,
                ),
                if (showAddRemoveButtons)
                  const SizedBox(height: TSizes.spaceBtwItems),

                ///Add,Remove button row with total price
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ///extra Space
                          const SizedBox(width: 70),

                          ///Add Remove Button
                          TProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => controller.addOneItemToCart(item),
                            remove: () =>
                                controller.removeOneItemFromCart(item),
                          ),
                        ],
                      ),

                      ///product total price
                      TProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
