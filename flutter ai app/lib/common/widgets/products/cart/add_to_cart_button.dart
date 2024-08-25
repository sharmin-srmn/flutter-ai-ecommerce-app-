import 'package:final_project_shopping_app/common/widgets/login_signup/login_popup_alert.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:final_project_shopping_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return InkWell(
      onTap: () {
        final authUser = AuthenticationRepository.instance.authUser;
        if (authUser != null) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneItemToCart(cartItem);
        } else {
          Get.to(() => const LoginPopUpAlertScreen());
        }
      },
      child: Obx(() {
        final productQunatityInCart =
            cartController.getProductQunatityInCart(product.id);

        return Container(
          decoration: BoxDecoration(
            color:
                productQunatityInCart > 0 ? TColors.primaryColor : TColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusMd),
              bottomRight: Radius.circular(TSizes.productItemRadius),
            ),
          ),
          child: SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
              child: productQunatityInCart > 0
                  ? Text(
                      productQunatityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: TColors.white),
                    )
                  : const Icon(Iconsax.add, color: TColors.white),
            ),
          ),
        );
      }),
    );
  }
}
