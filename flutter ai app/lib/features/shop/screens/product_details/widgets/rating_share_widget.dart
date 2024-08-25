import 'package:final_project_shopping_app/features/admin_dashboard/screens/product/widgets/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../admin_dashboard/models/product_model.dart';
import '../../../../personalization/controllers/user_controller.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ///Rating
            Row(
              children: [
                const Icon(Iconsax.star5, color: Colors.amber, size: 25),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '5.0',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(text: '(199)'),
                ]))
              ],
            ),

            ///share Button
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share, size: TSizes.iconMd))
          ],
        ),

        //ONLY ADMIN WIN CAN SEE THAT BUTTON
        controller.user.value.role.toLowerCase() == 'admin'
            ? TextButton(
                onPressed: () =>
                    Get.to(() => TEditProductScreen(product: product)),
                child: const Icon(
                  Icons.edit,
                  size: 17,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
