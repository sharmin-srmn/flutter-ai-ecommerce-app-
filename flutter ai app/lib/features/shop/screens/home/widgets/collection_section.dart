import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../admin_dashboard/controllers/product/product_controller.dart';
import '../../../../admin_dashboard/models/product_model.dart';
import '../../all_products/all_products.dart';

// ignore: must_be_immutable
class TCollectionSection extends StatelessWidget {
  TCollectionSection({
    super.key,
    required this.controller,
    required this.title,
    this.sectionTitle = "",
    required this.sortableTitle,
    required this.products,
    this.sectionBanner = '',
    required this.fetchedProducts,
  });

  final ProductController controller;
  final String title, sortableTitle;
  String sectionBanner;
  String sectionTitle;
  final Future<List<ProductModel>> fetchedProducts;
  final RxList<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionTitle.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(81, 84, 67, 1),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox(),

        //SPACE
        const SizedBox(height: TSizes.spaceBtwItems),

        //BANNER FOR MENS COLLECTION
        sectionBanner.isNotEmpty
            ? SizedBox(
                // height: 380,
                width: double.infinity,
                child: TRoundedImage(
                  imageUrl: sectionBanner,
                  isNetworkImage: false,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),

        //SPACE
        const SizedBox(height: TSizes.spaceBtwItems),

        /// HEADING FOR  PRODUCT
        TSectionHeading(
          title: title,
          onPressed: () => Get.to(
            () => AllProducts(
              title: title,
              sortableTitle: sortableTitle,
              futureMethod: fetchedProducts,
            ),
          ),
        ),

        //SPACE
        const SizedBox(height: TSizes.spaceBtwItems),

        /// PRODUCTS
        Obx(
          () {
            if (controller.isLoading.value) {
              return const TVerticalProductShimmer();
            }

            if (products.isEmpty) {
              return Center(
                child: Text(
                  'No data found haha.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return TGridLayout(
                itemCount: products.length > 4 ? 4 : products.length,
                itemBuilder: (_, index) =>
                    TProductCardVertical(product: products[index]));
          },
        ),
      ],
    );
  }
}
