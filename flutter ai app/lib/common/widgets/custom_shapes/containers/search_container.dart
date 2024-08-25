import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/search_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    Key? key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(HomeSearchController());
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: TColors.darkerGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: TextFormField(
                  onEditingComplete: () {
                    final enteredText =
                        controller.searchTagController.text.trim();
                    if (enteredText.isNotEmpty) {
                      controller.searchProductByText(enteredText);
                    }
                  },
                  controller: controller.searchTagController,
                  readOnly: false,
                  decoration: InputDecoration(
                      hintText: text,
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none, // Remove focused border
                      enabledBorder: InputBorder.none),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await controller.showBottomSheetPickImage(context);
                },
                icon: const Icon(Icons.image_search),
                color: TColors.darkerGrey,
                tooltip: 'search by image',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
