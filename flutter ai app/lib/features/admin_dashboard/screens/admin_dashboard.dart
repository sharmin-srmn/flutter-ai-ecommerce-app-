import 'package:final_project_shopping_app/features/admin_dashboard/screens/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../common/widgets/list_tiles/settings_menu_tile.dart';
import 'banner/banner.dart';
import 'upload_category/category.dart';

class TAdminDashboardScreen extends StatelessWidget {
  const TAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Admin Dashboard',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADING
            Text(
              'Upload all the information',
              style: Theme.of(context).textTheme.labelMedium,
            ),

            //SPACE BETWEEN SECTIONS
            const SizedBox(height: TSizes.spaceBtwSections),

            //UPLOAD CATEGORY
            TSettingsMenuTile(
                icon: Iconsax.category,
                title: 'Category',
                subTitle:
                    'Upload, update, delete the  information about category.',
                onTap: () => Get.to(() => const SCategoryScreen())),

            //SPACE BETWEEN SECTIONS
            const SizedBox(height: TSizes.spaceBtwSections),

            //UPLOAD CATEGORY
            TSettingsMenuTile(
                icon: Iconsax.image,
                title: 'Banner',
                subTitle: 'Upload, update, delete banner image.',
                onTap: () => Get.to(() => const TBannerScreen())),

            //SPACE BETWEEN SECTIONS
            const SizedBox(height: TSizes.spaceBtwSections),

            //UPLOAD CATEGORY
            TSettingsMenuTile(
                icon: Iconsax.additem,
                title: 'Product ',
                subTitle: 'Upload, update, delete products.',
                onTap: () => Get.to(() => const TProductScreen())),
          ],
        ),
      )),
    );
  }
}
