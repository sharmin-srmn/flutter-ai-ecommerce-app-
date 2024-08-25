import 'package:final_project_shopping_app/common/widgets/login_signup/login_popup_alert.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/features/shop/controllers/cart_controller.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../features/shop/screens/cart/cart.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    //INSTANCE OF CARTCONTROLLER
    final controller = Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            AuthenticationRepository.instance.authUser != null &&
                    AuthenticationRepository.instance.authUser!.emailVerified
                //IF LOGGEDIN USER THEN REDIRECT TO CART SCREEN
                ? Get.to(() => const CartScreen())
                //IF NOT LOGGED IN THEN REDIRECT TO POPUPSCREEN
                : Get.to(() => const LoginPopUpAlertScreen());
          },
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        AuthenticationRepository.instance.authUser != null &&
                AuthenticationRepository.instance.authUser!.emailVerified
            //IF USER LOGGED IN THEN SHOW THE  TEXT OF THE CART
            ? Positioned(
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: counterBgColor ??
                        (dark ? TColors.white : TColors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Obx(
                      () => Text(
                        controller.noOfCatItems.value.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                              color: counterTextColor ??
                                  (dark ? TColors.black : TColors.white),
                              fontSizeFactor: 0.8,
                            ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
