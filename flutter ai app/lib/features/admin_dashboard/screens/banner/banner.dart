import 'package:final_project_shopping_app/features/admin_dashboard/screens/banner/widgets/all_banner_images.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/screens/banner/widgets/upload_banner_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../utils/constants/sizes.dart';

class TBannerScreen extends StatelessWidget {
  const TBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Banner Page',
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
                  title: 'Upload Banner',
                  subTitle: 'Add new banner image.',
                  onTap: () => Get.to(() => const TUploadBannerScreen())),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //VIEW ALL PRODUCT
              TSettingsMenuTile(
                icon: Iconsax.eye,
                title: 'All Banner Images',
                subTitle: 'View all Banner Images.',
                onTap: () => Get.to(
                  () => const AllBannerListScreen(),
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
