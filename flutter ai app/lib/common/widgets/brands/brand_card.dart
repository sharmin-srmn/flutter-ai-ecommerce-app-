import 'package:final_project_shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import 'package:final_project_shopping_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:final_project_shopping_app/utils/constants/enums.dart';
import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  final bool showBorder;
  final void Function()? onTap;
  final String brand;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,

      ///container design
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          children: [
            //Icon
            Flexible(
              child: TCircularImage(
                width: 30,
                height: 30,
                isNetworkImage: false,
                image: TImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? TColors.white : TColors.white,
              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems),

            //text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                      title: brand, brandTextSize: TextSizes.large),
                  Text(
                    'All Products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
