import 'package:final_project_shopping_app/common/widgets/images/t_rounded_image.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TUploadBannerScreen extends StatelessWidget {
  const TUploadBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Upload Banner Image',
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
                'Upload the banner image for Home Page',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //TEXT FIELD AND BUTTONS
              Form(
                key: controller.uploadBannerFormKey,
                child: Column(
                  children: [
                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //IMAGE FIELD
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //CAMERA ICON
                              const Icon(Iconsax.camera),
                              TextButton(
                                onPressed: () async {
                                  await controller.uploadBannerImage();
                                  // print(controller.imageUrl);
                                },
                                //TEXT FOR CHOOSING IMAGE
                                child: const Text('Choose Banner Image'),
                              ),
                            ],
                          ),

                          //IMAGE
                          controller.imageUploading.value
                              ? TRoundedImage(
                                  imageUrl: controller.imageUrl,
                                  width: 320,
                                  height: 200,
                                  isNetworkImage: true,
                                )
                              : const TRoundedImage(
                                  imageUrl: TImages.noImage,
                                  width: 320,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  isNetworkImage: false,
                                ),
                        ],
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //IS ACTIVE FIELD
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isActive.value,
                            onChanged: (value) => controller.isActive.value =
                                !controller.isActive.value,
                          ),
                        ),
                        const Text(TTexts.isActiveBanner),
                      ],
                    ),

                    //SPACE BETWEEN SECTIONS
                    const SizedBox(height: TSizes.spaceBtwSections),

                    //UPLOAD CATEGORY BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.uploadBanner(),
                        child: const Text(
                          'Upload Banner',
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
