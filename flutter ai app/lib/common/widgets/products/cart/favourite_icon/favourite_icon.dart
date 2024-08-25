import 'package:final_project_shopping_app/common/widgets/login_signup/login_popup_alert.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../features/shop/controllers/favourites_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../Icons/t_circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        icon:
            controller.isFavourites(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourites(productId) ? TColors.error : null,
        onPressed: () {
          final authUser = AuthenticationRepository.instance.authUser;
          if (authUser != null) {
            controller.toggleFavouriteProduct(productId);
          } else {
            Get.to(() => const LoginPopUpAlertScreen());
          }
        },
      ),
    );
  }
}
