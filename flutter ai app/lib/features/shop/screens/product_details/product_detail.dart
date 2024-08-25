import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:final_project_shopping_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:final_project_shopping_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:final_project_shopping_app/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../admin_dashboard/models/product_model.dart';
import '../product_reviews/product_reviews.dart';
import 'widgets/bottom_add_to_cart_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///**1-product image slider
            TProductImageSlider(product: product),

            ///**2- Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating and share button
                  TRatingAndShare(
                    product: product,
                  ),

                  ///price ,title,stock and Brand
                  TProductMetaData(
                    product: product,
                  ),

                  // ///Attributes

                  // const TProductAttributes(),
                  // const SizedBox(height: TSizes.spaceBtwSections),

                  ///Checkout Buttons
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Checkout'))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ReadMoreText(
                    "${product.title.capitalizeFirst} is ${product.description}",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  ///Review
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          onPressed: () =>
                              Get.to(() => const ProductReviewScreen())),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TBottomAddToCart(product: product),
    );
  }
}
