import 'package:final_project_shopping_app/common/widgets/images/t_rounded_image.dart';
import 'package:final_project_shopping_app/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/upload_category_controller.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    //FINDING EXISTING CATEGORY CONTROLLER
    final controller = UploadCategoryController.instance;

    //FETCHNG AND ASSIGNING THE CORRESPONDING CATEGORY VALUES
    final TextEditingController categoryController =
        TextEditingController(text: category.name.capitalize);
    final TextEditingController parentCategoryController =
        TextEditingController(text: category.parentId.capitalize);

    final TextEditingController imageController =
        TextEditingController(text: category.image);
    final isFeatured = category.isFeatured.obs;

    //
    controller.categoryName.text = categoryController.text;
    controller.parentCategoryName.text = parentCategoryController.text;

    controller.imageUrl = imageController.text;
    controller.isFeatured.value = isFeatured.value;

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Edit category',
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
                'Update all the information about category.',
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

                    Row(
                      children: [
                        //CAMERA ICON
                        const Icon(
                          Iconsax.camera,
                          size: 20,
                        ),
                        //TEXT BUTTON
                        TextButton(
                          onPressed: () async {
                            if (!controller.imageDeleting.value) {
                              await controller
                                  .deleteCategoryImage(imageController.text);
                            }
                            final imageUrl =
                                await controller.uploadCategoryImage();

                            // if (imageUrl != null) {
                            imageController.text = imageUrl;
                            controller.imageUrl = imageUrl;

                            // }
                          },
                          child: const Text('Change image'),
                        ),
                      ],
                    ),

                    //IMAGE FIELD
                    //IMAGE
                    Obx(
                      () => Stack(
                        children: [
                          //IF DELETING IMAGE HAS BEEN START AND NEW IMAGE UPLOADING HAS NOT BEENSTART THEN DEFAULT ASSET IMAGE
                          controller.imageDeleting.value &&
                                  !controller.imageUploading.value
                              ? const TRoundedImage(
                                  imageUrl: TImages.noImage,
                                  height: 200,
                                  width: 320,
                                )
                              // OTHERWISE OLD IMAGE OR  NEW IMAGE WITH SHIMMER REFRESHING SHIMMER EFFECT
                              : TRoundedImage(
                                  isNetworkImage: true,
                                  imageUrl: imageController.text,
                                  height: 200,
                                  width: 320,
                                ), // The cross icon
                          controller.imageDeleting.value
                              ? const SizedBox()
                              : Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await controller.deleteCategoryImage(
                                          imageController.text);
                                      imageController.text = '';
                                      controller.imageUrl =
                                          imageController.text;
                                    },
                                    child: const Icon(
                                      Icons
                                          .close, // Choose the icon you want to use
                                      color: Colors
                                          .red, // Choose the color of the icon
                                      size: 24, // Choose the size of the icon
                                    ),
                                  ),
                                ),
                        ],
                      ),
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
                            : () => controller.updateCategory(category.id),
                        child: const Text(
                          'Update Category',
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
