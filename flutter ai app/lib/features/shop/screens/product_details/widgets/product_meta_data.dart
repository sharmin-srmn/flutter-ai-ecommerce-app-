import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:final_project_shopping_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../admin_dashboard/controllers/product/product_controller.dart';
import '../../../../admin_dashboard/models/product_model.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    // final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Price and sale price
        Row(
          children: [
            ///sale tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('$salePercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black)),
            ),

            const SizedBox(width: TSizes.spaceBtwItems),

            ///  PRICE SECTION
            //PREVIOUS PRICE
            Text(
              (product.price - product.salePrice > 0)
                  ? 'BDT ${product.price}'
                  : '',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),

            //SPACE BETWEEN TWO ITEMS
            const SizedBox(width: TSizes.spaceBtwItems),

            //CURENT PRICE PRICE
            TProductPriceText(
                price: product.price - product.salePrice > 0
                    ? (product.salePrice.toString())
                    : (product.price.toString()),
                isLarge: true),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        ///Title
        TProductTitleText(title: product.title.capitalize!),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
                '${controller.getProductStockStatus(product.stock)} - ${product.stock} ps',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        ///BRAND ICON
        Row(
          children: [
            const TCircularImage(
              //BRAND IMAGE ER KAAJ PORE KORBO
              image: TImages.shoeIcon,
              width: 32,
              height: 32,
              // overlayColor: dark ? TColors.white : TColors.black,
              overlayColor: TColors.white,
            ),

            //SPACE BETWEEN TWO ITEMS
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            //PRODUCT BRAND NAME
            TBrandTitleWithVerifiedIcon(
                title: product.brand.capitalize!,
                brandTextSize: TextSizes.medium),
          ],
        ),
        //SPACE BETWEEN TWO ITEMS
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
