import 'package:final_project_shopping_app/features/admin_dashboard/screens/upload_category/widgets/all_category.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/screens/upload_category/widgets/upload_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../utils/constants/sizes.dart';

class SCategoryScreen extends StatelessWidget {
  const SCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Category Page',
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
                'Upload, update, delete Banner image',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //ADD PRODUCT
              TSettingsMenuTile(
                  icon: Iconsax.add_square,
                  title: 'Upload Category',
                  subTitle: 'Add new Category.',
                  onTap: () => Get.to(() => const TUploadCategoryScreen())),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //VIEW ALL PRODUCT
              TSettingsMenuTile(
                icon: Iconsax.eye,
                title: 'All Categories',
                subTitle: 'View all Categories information.',
                onTap: () => Get.to(
                  () => const AllCategoryListScreen(),
                ),
              ),

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
