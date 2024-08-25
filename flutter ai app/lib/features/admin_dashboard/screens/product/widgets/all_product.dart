import 'package:final_project_shopping_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../controllers/product/product_controller.dart';

// import '../../../controllers/product/product_controller.dart';

class TAllProductScreen extends StatelessWidget {
  const TAllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'All Products',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(
        () {
          //OBX TO REACTIVELY UPDATE UI WHEN BANNERSCHANGE
          if (controller.allProducts.isEmpty) {
            return const Center(
              child: Text('No Product uploaded yet.'),
            );
          } else {
            return ListView.separated(
                // shrinkWrap: true,
                itemCount: controller.allProducts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = controller.allProducts[index];

                  return TProductCardHorizontal(product: product);
                });
          }
        },
      ),
    );
  }
}
