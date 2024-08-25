import 'package:final_project_shopping_app/common/widgets/brands/brand_card.dart';
import 'package:final_project_shopping_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:final_project_shopping_app/features/shop/controllers/brand_controller.dart';
import 'package:final_project_shopping_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        //APPBAR FOR SPECIFIC BRAND PRODUCTS
        appBar: AppBar(
          title: Text(brand.capitalize!),
        ),

        //BODY
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //BRAND CARD
                TBrandCard(showBorder: true, brand: brand),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                FutureBuilder(
                    future: controller.fetchBrandProducts(brand),
                    builder: (context, snapshot) {
                      //HANDLE LOADER, NO RECORD
                      const loader = TVerticalProductShimmer();
                      final widget = TCloudHelperFunction.checkMultiRecordState(
                          snapshot: snapshot, loader: loader);
                      if (widget != null) {
                        return widget;
                      }
                      final brandProducts = snapshot.data!;
                      return TSortableProducts(
                          products: brandProducts,
                          sortableTitle: 'New Arrivals');
                    })
              ],
            ),
          ),
        ));
  }
}
