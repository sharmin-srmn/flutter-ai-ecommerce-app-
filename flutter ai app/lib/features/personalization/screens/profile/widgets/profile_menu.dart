import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    Key? key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
    this.disabled = false, // Add a flag to indicate if the text is disabled
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;
  final bool disabled; // Flag to indicate if the text is disabled

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            //THIS IS FOR FIELS TITLE - USERNAME< PHONE NUMBER ETC
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: disabled
                          ? Colors.grey.shade600
                          : dark
                              ? Colors.white
                              : Colors
                                  .black, // Change text color based on disabled flag
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            //THIS IS FOR VALUE
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: disabled
                          ? Colors.grey.shade600
                          : dark
                              ? Colors.white
                              : Colors
                                  .black, // Change text color based on disabled flag
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            //THIS IS FOR ICON
            Expanded(
              child: Icon(
                disabled ? Icons.not_interested : icon,
                size: 10,
                color: disabled
                    ? Colors.grey.shade600
                    : dark
                        ? Colors.white
                        : Colors
                            .black, // Change icon color based on disabled flag
              ),
            ),
          ],
        ),
      ),
    );
  }
}
