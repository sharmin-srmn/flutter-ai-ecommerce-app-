import 'package:final_project_shopping_app/features/admin_dashboard/screens/banner/widgets/edit_banner.dart';
import 'package:flutter/material.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/banner_controller.dart';
import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import 'package:get/get.dart';

class AllBannerListScreen extends StatelessWidget {
  const AllBannerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerController>();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Uploaded Banners',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        //OBX TO REACTIVELY UPDATE UI WHEN BANNERSCHANGE
        if (controller.allBanners.isEmpty) {
          return const Center(
            child: Text('No banners uploaded yet.'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 5),
            child: ListView.separated(
              itemCount: controller.allBanners.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final banner = controller.allBanners[index];
                return ListTile(
                  leading: TCircularImage(
                    image: banner.imageUrl,
                    width: 80,
                    height: 80,
                    isNetworkImage: true,
                  ),
                  title: Text(
                      'Banner ${index + 1}'), // You can add more details here if needed
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //EDIT ICON FOR BANNER
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              Get.to(() => EditBannerScreen(banner: banner))),

                      //DELETE ICON FOR BANNER
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteBannerWarningPopup(banner.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
