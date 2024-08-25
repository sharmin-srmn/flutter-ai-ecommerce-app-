import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../Icons/t_circular_icon.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //REMOVE BUTTON
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: THelperFunctions.isDarkMode(context)
              ? TColors.white
              : TColors.black,
          backGroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
          onPressed: remove,
        ),

        //SPACE BETWEEN ITEMS
        const SizedBox(width: TSizes.spaceBtwItems),

        //QUANTITY
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),

        //SPACE BETWEEN ITEMS
        const SizedBox(width: TSizes.spaceBtwItems),

        //ADD BUTTON
        TCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: TColors.white,
          backGroundColor: TColors.primaryColor,
          onPressed: add,
        ),
      ],
    );
  }
}
