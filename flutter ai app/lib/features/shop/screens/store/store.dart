import 'package:final_project_shopping_app/common/widgets/appbar/tabbar.dart';
import 'package:final_project_shopping_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:final_project_shopping_app/common/widgets/brands/brand_card.dart';
import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:final_project_shopping_app/features/shop/controllers/brand_controller.dart';
import 'package:final_project_shopping_app/features/shop/screens/store/widgets/brand_products.dart';
import 'package:final_project_shopping_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/shimmers/brand_shimmer.dart';
import '../../controllers/category_controller.dart';
import 'widgets/all_brand_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  Future<void> _refresh() async {
    // Fetch data again, for example:
    CategoryController.instance.featuredCategories;
    await BrandController.instance.fetchAllBrands();
    // You can add more data fetching here if needed

    // Optional: Add a delay to show the refresh indicator for a certain amount of time
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());
    // brandController.fetchBrandsByCategoryName(categories[]);

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        ///AppBar
        appBar: TAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: const [
            TCartCounterIcon(
              iconColor: null,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScroll) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 440,
                  automaticallyImplyLeading: false,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,

                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ///search bar
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const TSearchContainer(
                            text: 'Search in Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// HEADING / TITLE FOR BRANDS - FEATURED BRANDS
                        TSectionHeading(
                            title: 'Featured Brands',
                            onPressed: () => Get.to(() => AllBrandScreen(
                                  brands: brandController.allBrands,
                                ))),

                        //SPACE
                        const SizedBox(height: TSizes.spaceBtwSections / 1.5),

                        ///$ BRAND NAMES WILL SHOW
                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const SBrandShimmer();
                          }

                          if (brandController.allBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No data Found',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }

                          return TGridLayout(
                            itemCount: brandController.allBrands.length > 4
                                ? 4
                                : brandController.allBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.allBrands[index];
                              return TBrandCard(
                                showBorder: true,
                                brand: brand,
                                onTap: () =>
                                    Get.to(() => BrandProducts(brand: brand)),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),

                  ///Tab NAME ACCORDING TO CATEGORIES
                  // bottom: TTabBar(
                  //   tabs: categories
                  //       .map((category) => Tab(
                  //             child: Text(category.name),
                  //           ))
                  //       .toList(),
                  // ),
                  bottom: TTabBar(
                    tabs: categories.map((category) {
                      return Tab(
                        child: Text(category.name),
                      );
                    }).toList(),
                  ),
                ),
              ];
            },
            body:
                //  Obx(() {
                //   final brands =
                //       brandController.fetchBrandsByCategoryName(categories[0].name);
                //   if (brandController.isLoading.value) {
                //     return const SBrandShimmer();
                //   }
                //   if (brandController.brandsByCategoryName.isEmpty) {
                //     return Center(
                //       child: Text(
                //         'No data Found',
                //         style: Theme.of(context).textTheme.bodyMedium,
                //       ),
                //     );
                //   }
                // return

                TabBarView(
              children: categories.map(
                (category) {
                  //AVAILABLE BRANDS FOR SPECIFIC CATEGORY

                  return TCategoryTab(
                    category: category,
                  );
                },
              ).toList(),
            ),
            // }
            // ),
          ),
        ),
      ),
    );
  }
}
