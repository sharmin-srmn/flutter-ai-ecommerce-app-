import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/add_product.dart';
import 'widgets/all_product.dart';

class TProductScreen extends StatelessWidget {
  const TProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Product page',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      //BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HEADING
              Text(
                'Upload, update, delete product',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //ADD PRODUCT
              TSettingsMenuTile(
                  icon: Iconsax.add_square,
                  title: 'Add Product',
                  subTitle: 'Add new product with details',
                  onTap: () => Get.to(() => const TAddProductScreen())),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //VIEW ALL PRODUCT
              TSettingsMenuTile(
                  icon: Iconsax.eye,
                  title: 'All Products',
                  subTitle: 'View all products.',
                  onTap: () => Get.to(() => const TAllProductScreen())),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //TEXT FIELD AND BUTTONS
            ],
          ),
        ),
      ),
    );
  }
}
