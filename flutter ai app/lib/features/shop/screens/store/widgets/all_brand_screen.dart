import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/brands/brand_card.dart';
import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import 'brand_products.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key, required this.brands});

  final List<String> brands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          title: Text('Brands'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //SECTION HEADING FOR BRANDS
                const TSectionHeading(
                  title: 'All Our Brands',
                  showActionButton: false,
                ),

                //SPACE
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                //BRANDS GRID
                TGridLayout(
                    mainAxisExtent: 80,
                    itemCount: brands.length,
                    itemBuilder: (context, index) => TBrandCard(
                          showBorder: true,
                          brand: brands[index],
                          onTap: () =>
                              Get.to(() => BrandProducts(brand: brands[index])),
                        ))
              ],
            ),
          ),
        ));
  }
}
