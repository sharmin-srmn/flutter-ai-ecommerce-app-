import 'package:final_project_shopping_app/common/widgets/products/cart/favourite_icon/favourite_icon.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/product/product_controller.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../cart/add_to_cart_button.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    ///Container with side paddings,color,edges,radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(
          product: product,
        ),
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productItemRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Thumbnail, wishlist button,discount tag
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //Thumbnail Image
                  Center(
                    child: TRoundedImage(
                        isNetworkImage: true,
                        imageUrl: product.image,
                        applyImageRadius: true),
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
                                horizontal: TSizes.sm, vertical: TSizes.xs),
                            child: Text('$salePercentage%',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(color: TColors.black)),
                          ),
                        )
                      : const SizedBox(),

                  /// Favorite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(
                      productId: product.id,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// DETAILS SECTION
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE OF THE PRODUCT
                  TProductTitleText(
                      title: product.title.capitalize!, smallSize: true),

                  /// SPACE BETWEEN TITLE AND BRAND
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  /// BRAND OF THE PRODUCT
                  TBrandTitleWithVerifiedIcon(title: product.brand.capitalize!),
                ],
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Text(
                //IF IT IS IN SALE THEN WILL SHOW THE PREVIOUS PRICE WITH LINE THROUGH OTHERWISE IT WILL SHOW NOTHING
                (product.price - product.salePrice > 0)
                    ? 'BDT ${product.price.toString()}'
                    : '',
                style: const TextStyle(
                  fontSize: 11,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),

            ///THIS WILL SHOW THE CURRENT PRICE OF THE RPODUCT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                    child: TProductPriceText(
                        price: (product.price - product.salePrice > 0)
                            ? (product.salePrice).toString()
                            : (product.price).toString()),
                  ),
                ),

                ///Add to cart button
                ProductCartAddToCartButton(
                  product: product,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
