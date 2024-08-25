import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/product/product_controller.dart';

class TAddProductScreen extends StatelessWidget {
  const TAddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //REFRESH PRODUCT DATA
    final controller = ProductController.instance;
    controller.resetFormFields();

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Add new product',
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
                'Fill all the fields about the product ',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              //SPACE BETWEEN SECTIONS
              const SizedBox(height: TSizes.spaceBtwSections),

              //TEXT FIELD AND BUTTONS
              Form(
                key: controller.uploadProductFormKey,
                child: Column(
                  children: [
                    // PRODUCT TITLE
                    TextFormField(
                      controller: controller.title,
                      validator: (value) =>
                          TValidator.validateEmptyText('Product Title', value),
                      expands: false,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: TTexts.productTitle,
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

                    // PRODUCT ID
                    TextFormField(
                      controller: controller.productId,
                      validator: (value) =>
                          TValidator.validateEmptyText('Product Id', value),
                      expands: false,
                      minLines: 1,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: TTexts.productId,
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

                    // PRODUCT DESCRIPTION
                    TextFormField(
                      controller: controller.description,
                      validator: (value) => TValidator.validateEmptyText(
                          'Product Description', value),
                      expands: false,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        // floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: TTexts.productDescription,
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

                    // BRAND
                    TextFormField(
                      controller: controller.brand,
                      validator: (value) =>
                          TValidator.validateEmptyText('Brand', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.brand,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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

                    // CATEGORY
                    TextFormField(
                      controller: controller.category,
                      validator: (value) =>
                          TValidator.validateEmptyText('Category', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.category,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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

                    // TAG
                    TextFormField(
                      controller: controller.tag,
                      validator: (value) =>
                          TValidator.validateEmptyText('Tag', value),
                      expands: false,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: TTexts.tag,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(
                          Iconsax.tag,
                          size: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // STOCK OF PRODUCTS
                    TextFormField(
                      controller: controller.stock,
                      validator: (value) => TValidator.validateEmptyText(
                          'Stocks of products', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.stock,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(
                          Icons.list,
                          size: 14,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // PRICE
                    TextFormField(
                      controller: controller.price,
                      validator: (value) =>
                          TValidator.validateEmptyText('Price', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.productPrice,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money_outlined),
                        prefix: Padding(
                          padding: EdgeInsets.only(
                              right: 8,
                              left: 6), // Add right padding to create space
                          child: Text(
                            'Tk',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),

                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // SALE PRICE
                    TextFormField(
                      controller: controller.salePrice,
                      validator: (value) =>
                          TValidator.validateEmptyText('Sale Price', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.productSalePrice,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money_outlined),
                        prefix: Padding(
                          padding: EdgeInsets.only(
                              right: 8,
                              left: 6), // Add right padding to create space
                          child: Text(
                            'Tk',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),

                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //IS FEATURED
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isFeatured.value,
                            onChanged: (value) => controller.isFeatured.value =
                                !controller.isFeatured.value,
                          ),
                        ),
                        const Text(TTexts.isFeaturedProduct),
                      ],
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //UPLOAD IMAGE OF PRODUCT
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              //ICON FOR CAMERA
                              const Icon(
                                Iconsax.camera,
                                size: 20,
                              ),
                              //TEXT BUTTON
                              TextButton(
                                onPressed: () async {
                                  await controller.uploadProductImage();
                                },
                                child: const Text('Upload image'),
                              ),
                            ],
                          ),

                          //DEFAULT IMAGE ? NETWORK IMAGE
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
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),

                    //UPLOAD PRODUCT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.uploadProduct(),
                        child: const Text(
                          'Upload Product',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
