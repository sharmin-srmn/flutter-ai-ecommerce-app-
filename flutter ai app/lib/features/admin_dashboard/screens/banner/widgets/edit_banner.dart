import 'package:final_project_shopping_app/common/widgets/images/t_rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/banner_controller.dart';
import '../../../models/banner_model.dart';

class EditBannerScreen extends StatelessWidget {
  final BannerModel banner;

  const EditBannerScreen({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController imageUrlController =
        TextEditingController(text: banner.imageUrl);
    final controller = Get.find<BannerController>();

    final isActive = banner.active.obs; // Get the BannerController

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Edit Banner'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SHOW THE IMAGE FROM IMAGE URL
            banner.imageUrl.isNotEmpty
                ? Center(
                    child: TRoundedImage(
                      imageUrl: banner.imageUrl,
                      width: 400,
                      isNetworkImage: true,
                    ),
                  )
                : const SizedBox(),

            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: isActive.value,
                    onChanged: (value) {
                      isActive.value = !isActive.value!;
                      banner.active = value;
                    },
                  ),
                ),
                const Text(TTexts.isActiveBanner),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                // Update banner information
                banner.imageUrl = imageUrlController.text;

                controller.updateBanner(banner);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
