import 'package:final_project_shopping_app/common/widgets/images/t_rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/upload_category_controller.dart';

class TUploadCategoryScreen extends StatelessWidget {
  const TUploadCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadCategoryController());

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Upload category',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      //BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //HEADING
              Text(
                'Upload all the information about category.',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //TEXT FIELD AND BUTTONS
              Form(
                key: controller.uploadCategoryFormKey,
                child: Column(
                  children: [
                    // CATEGORY FIELD
                    TextFormField(
                      controller: controller.categoryName,
                      validator: (value) =>
                          TValidator.validateEmptyText('Category Name', value),
                      expands: false,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: TTexts.categoryName,
                        prefixIcon: Icon(
                          Iconsax.category,
                          size: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //PARENTCATEGORY FIELD
                    TextFormField(
                      controller: controller.parentCategoryName,
                      expands: false,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: TTexts.parentCategoryName,
                        prefixIcon: Icon(
                          Iconsax.text,
                          size: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //IMAGE FIELD
                    Obx(
                      () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Iconsax.camera),
                                TextButton(
                                  onPressed: () async {
                                    await controller.uploadCategoryImage();
                                  },
                                  child: const Text('Upload image'),
                                ),
                              ],
                            ),
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
                        );
                      },
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //IS FEATURED FIELD

                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isFeatured.value,
                            onChanged: (value) => controller.isFeatured.value =
                                !controller.isFeatured.value,
                          ),
                        ),
                        const Text(TTexts.isFeatured),
                      ],
                    ),

                    //SPACE BETWEEN SECTIONS
                    const SizedBox(height: TSizes.spaceBtwSections),

                    //UPLOAD CATEGORY BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.imageUploading.value
                            ? null // Disable the button if image is uploading
                            : () => controller.uploadCategory(),
                        child: const Text(
                          'Upload Category',
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
