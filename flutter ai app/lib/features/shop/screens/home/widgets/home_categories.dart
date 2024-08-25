import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/category_shimmer.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/product/product_controller.dart';
import 'package:final_project_shopping_app/features/shop/controllers/category_controller.dart';
import 'package:final_project_shopping_app/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
    required this.categoryController,
  });

  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (categoryController.isLoading.value) {
          return const TCategoryShimmer();
        }

        if (categoryController.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No data Found!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }
        return SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: TCircularImage(
                    padding: 5,
                    height: 40,
                    width: 40,
                    isNetworkImage: true,
                    image: category.image,
                  ),
                  title: Text(category.name),
                  onTap: () => Get.to(() => AllProducts(
                        title: category.name,
                        sortableTitle: 'New Arrivals',
                        futureMethod: ProductController.instance
                            .fetchProductsBytagName(category.name),
                      )),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
