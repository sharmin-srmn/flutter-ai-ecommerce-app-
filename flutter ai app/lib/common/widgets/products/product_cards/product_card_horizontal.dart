import 'package:final_project_shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/t_brand_title_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/product/product_controller.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/admin_dashboard/screens/product/widgets/edit_product.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/t_rounded_image.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 300,
      height: 150, // Adjusted height to fit content
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productItemRadius),
        color: dark ? TColors.darkerGrey : TColors.white,
      ),
      child: SizedBox(
        height: 400,
        width: 300,
        child: Row(
          children: [
            //THIS IS FOR IMAGE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                  child: TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Stack(
                      children: [
                        // Thumbnail Image
                        Center(
                          child: TRoundedImage(
                            height: 100,
                            width: 100,
                            isNetworkImage: true,
                            imageUrl: product.image,
                            applyImageRadius: true,
                          ),
                        ),

                        ///sale tag
                        salePercentage!.compareTo('0') > 0
                            ? Positioned(
                                top: 12,
                                child: TRoundedContainer(
                                  radius: TSizes.sm,
                                  backgroundColor:
                                      TColors.secondaryColor.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                      vertical: TSizes.xs),
                                  child: Text('$salePercentage%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(color: TColors.black)),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),

            //THIS IS FOR DETAILS
            Container(
              height: 250,
              width: 170,
              // color: Colors.amber,
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PRODUCT TITLE
                  TProductTitleText(
                      title: product.title.capitalize!, smallSize: true),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  //PODUCT ID
                  TBrandTitleText(
                      title: "Product ID - ${product.productId.toString()}"),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  //PRODUCT BRAND
                  TBrandTitleWithVerifiedIcon(
                    title: product.brand.capitalize!,
                  ),

                  //PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      TProductPriceText(
                        price: (product.price - product.salePrice > 0)
                            ? (product.salePrice).toString()
                            : (product.price).toString(),
                        isLarge: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //ICON
            Column(
              children: [
                SizedBox(
                  height: 40,
                  child: IconButton(
                    onPressed: () =>
                        Get.to(() => ProductDetailScreen(product: product)),
                    icon: const Icon(
                      Icons.remove_red_eye,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: IconButton(
                    onPressed: () =>
                        Get.to(() => TEditProductScreen(product: product)),
                    icon: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: IconButton(
                    onPressed: () {
                      controller.deleteProductWarningPopup(product.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
