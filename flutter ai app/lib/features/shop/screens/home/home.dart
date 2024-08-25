import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:final_project_shopping_app/features/shop/controllers/all_products_controller.dart';
import 'package:final_project_shopping_app/features/shop/controllers/category_controller.dart';
import 'package:final_project_shopping_app/features/shop/screens/all_products/all_products.dart';
import 'package:final_project_shopping_app/features/shop/screens/home/widgets/drawer.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:final_project_shopping_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:final_project_shopping_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../admin_dashboard/controllers/product/product_controller.dart';
import 'widgets/collection_section.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleRefresh() async {
    Get.offAll(() => const NavigationMenu());
    return await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final categoryController = Get.put(CategoryController());
    final allProductsController = Get.put(AllProductsController());
    return Scaffold(
      drawer: TDrawer(
        categoryController: categoryController,
      ),

      //CUSTOM SLIVER STICKY APPBAR
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: const Color.fromRGBO(81, 84, 67, 1),
        height: 300,
        animSpeedFactor: 3,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: THomeAppBar(),
            ),

            //BODY SECTION NEXT TO SLIVER APPBAR
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///header
                    const TPrimaryHeaderContainer(
                      child: Column(
                        children: [
                          //SPACE BETWEEN SLIVER APPBAR AND SEARCH BAR
                          SizedBox(
                            height: 30,
                          ),

                          ///SearchBar
                          TSearchContainer(text: 'Search in Store'),
                          SizedBox(height: TSizes.spaceBtwSections),
                          SizedBox(height: TSizes.spaceBtwSections),
                        ],
                      ),
                    ),

                    //BODY
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        children: [
                          //HOME PAGE SLIDERS
                          const TPromoSlider(),

                          //SPACE
                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// *********START OF NEW ARRIVAL PRODUCT SECTION **********///
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(81, 84, 67, 1),
                            ),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Text(
                              'New Arrivals',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          ///
                          GestureDetector(
                            onTap: () => Get.to(
                              () => AllProducts(
                                title: 'New Arrivals',
                                sortableTitle: 'New Arrivals',
                                futureMethod:
                                    controller.fetchNewArrivalsProducts(),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 380,
                                  width: 260,
                                  //BANNER IMAGE OF NEW ARRIVAL SECTION
                                  child: TRoundedImage(
                                    imageUrl: TImages.newArrivalBanner,
                                    isNetworkImage: false,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                //SPACE
                                const SizedBox(width: 10),
                                //TEXT NEXT TO BANNER IMAGE
                                Container(
                                  height: 450,
                                  alignment: Alignment.center,
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      'AUTUMN SEASON',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //SPACE
                          const SizedBox(height: TSizes.spaceBtwItems),

                          /// HEADING FOR ( NEW ARRIVAL PRODUCT )
                          TSectionHeading(
                            title: 'New Arrivals',
                            onPressed: () => Get.to(
                              () => AllProducts(
                                title: 'New Arrivals',
                                sortableTitle: 'New Arrivals',
                                // query: FirebaseFirestore.instance
                                //     .collection('Products')
                                //     .where('IsFeatured', isEqualTo: true)
                                //     .limit(2),
                                futureMethod:
                                    controller.fetchNewArrivalsProducts(),
                              ),
                            ),
                          ),

                          //SPACE
                          const SizedBox(height: TSizes.spaceBtwItems),

                          ///NEW ARRIVALS PRODUCTS
                          Obx(
                            () {
                              if (controller.isLoading.value) {
                                return const TVerticalProductShimmer();
                              }

                              if (controller.newArrivalsProducts.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No data found haha.',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }

                              return TGridLayout(
                                  //(controller.newArrivalsProducts.length) WILL DISPLAY FULL NEW ARRIVAL PRODUCTS
                                  itemCount:
                                      controller.newArrivalsProducts.length > 4
                                          ? 4
                                          : controller
                                              .newArrivalsProducts.length,
                                  itemBuilder: (_, index) =>
                                      TProductCardVertical(
                                          product: controller
                                              .newArrivalsProducts[index]));
                            },
                          ),

                          /// ********* END OF NEW ARRIVAL PRODUCT SECTION **********///

                          //SPACE
                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// ********* START OF MENS  PRODUCT SECTION **********///
                          /// MENS SHIRT
                          TCollectionSection(
                            sectionTitle: 'Mens Collection',
                            title: 'Mens Shirt',
                            sortableTitle: 'New Arrivals',
                            sectionBanner: TImages.menzCollectionBanner,
                            controller: controller,
                            fetchedProducts:
                                controller.fetchMensShirt('mens shirt'),
                            products: controller.mensFeaturedShirt,
                          ),

                          /// MENS TSHIRT
                          TCollectionSection(
                            title: 'Mens Tshirt',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchMensTshirt('mens tshirt'),
                            products: controller.mensFeaturedTshirt,
                          ),

                          /// MENS PANT
                          TCollectionSection(
                            title: 'Mens Pant',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchMensPant('mens pant'),
                            products: controller.mensFeaturedPant,
                          ),

                          /// MENS PANJABI
                          TCollectionSection(
                            title: 'Mens Panjabi',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchMensPanjabi('mens panjabi'),
                            products: controller.mensFeaturedPanjabi,
                          ),

                          /// ********* END OF MENS  PRODUCT SECTION **********///

                          //SPACE
                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// ********* START OF WOMENS  PRODUCT SECTION **********///
                          /// SAARE
                          TCollectionSection(
                            sectionTitle: 'Womens Collection',
                            title: 'Saare',
                            sortableTitle: 'New Arrivals',
                            sectionBanner: TImages.womenzCollectionBanner,
                            controller: controller,
                            fetchedProducts:
                                controller.fetchWomensSaare('saare'),
                            products: controller.womensFeaturedSaare,
                          ),

                          //SALWAR KAMIZ
                          TCollectionSection(
                            title: 'Ladies Suit',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts: controller.fetchWomensSuit('suit'),
                            products: controller.womensFeaturedSuit,
                          ),

                          //SALWAR KAMIZ
                          TCollectionSection(
                            title: 'Ladies Kurti',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchWomensKurti('kurti'),
                            products: controller.womensFeaturedKurti,
                          ),

                          //SALWAR KAMIZ
                          TCollectionSection(
                            title: 'Ladies Top',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchWomensTop('ladies top'),
                            products: controller.womensFeaturedTop,
                          ),

                          //ShIRT
                          TCollectionSection(
                            title: 'Ladies Shirt',
                            sortableTitle: 'New Arrivals',
                            controller: controller,
                            fetchedProducts:
                                controller.fetchWomensShirt('ladies shirt'),
                            products: controller.womensFeaturedShirt,
                          ),

                          /// ********* END OF WOMENS  PRODUCT SECTION **********///
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
