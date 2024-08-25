import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:final_project_shopping_app/features/shop/controllers/all_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/admin_dashboard/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts(
      {super.key, required this.products, required this.sortableTitle});

  final List<ProductModel> products;
  final String sortableTitle;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(AllProductsController());
    final controller = AllProductsController.instance;
    controller.assignProducts(products, sortableTitle);
    return Column(
      children: [
        ///DROP DOWN
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'New Arrivals',
            'Popular'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),

        //SPACE BETWEEN SECTIONS
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //PRODUCTS
        Obx(
          () => TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) =>
                  TProductCardVertical(product: controller.products[index])),
        )
      ],
    );
  }
}
