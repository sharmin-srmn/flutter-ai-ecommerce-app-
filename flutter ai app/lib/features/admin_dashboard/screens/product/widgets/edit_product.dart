import 'package:final_project_shopping_app/common/widgets/images/t_rounded_image.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class TEditProductScreen extends StatelessWidget {
  const TEditProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    final TextEditingController titleController =
        TextEditingController(text: product.title.capitalize);
    final TextEditingController productIdController =
        TextEditingController(text: product.productId.toString());
    final TextEditingController descriptionController =
        TextEditingController(text: product.description.capitalizeFirst);
    final TextEditingController brandController =
        TextEditingController(text: product.brand.capitalize);
    final TextEditingController categoryController =
        TextEditingController(text: product.category.capitalize);
    final TextEditingController tagsController =
        TextEditingController(text: product.tag.capitalize);
    final TextEditingController stockController =
        TextEditingController(text: (product.stock.toString()));
    final TextEditingController priceController =
        TextEditingController(text: product.price.toString());
    final TextEditingController salePriceController =
        TextEditingController(text: product.salePrice.toString());
    final TextEditingController imageController =
        TextEditingController(text: product.image);
    final isFeatured = product.isFeatured.obs;

    controller.title.text = titleController.text;
    controller.productId.text = productIdController.text;
    controller.description.text = descriptionController.text;
    controller.brand.text = brandController.text;
    controller.category.text = categoryController.text;
    controller.tag.text = tagsController.text;
    controller.stock.text = (stockController.text);
    controller.price.text = (priceController.text);
    controller.salePrice.text = (salePriceController.text);
    controller.imageUrl = imageController.text;
    controller.isFeatured.value = isFeatured.value;

    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Edit the product',
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
                'Edit the field about the product ',
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
                      minLines: 2,
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
                      maxLines: 5,
                      minLines: 1,
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
                              value: isFeatured.value,
                              onChanged: (value) {
                                isFeatured.value = !isFeatured.value;
                                controller.isFeatured.value = isFeatured.value;
                              }),
                        ),
                        const Text(TTexts.isFeaturedProduct),
                      ],
                    ),

                    //SPACE BETWEEN FIELDS
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //CAMERA ICON AND TEXTBUTTON
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
                                  .deleteProductImage(imageController.text);
                            }
                            final imageUrl =
                                await controller.uploadProductImage();

                            // if (imageUrl != null) {
                            imageController.text = imageUrl;
                            controller.imageUrl = imageUrl;

                            // }
                          },
                          child: const Text('Change image'),
                        ),
                      ],
                    ),

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
                                      await controller.deleteProductImage(
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

                    ///SPACE BETWEEN
                    const SizedBox(
                      height: 20,
                    ),

                    //UPLOAD PRODUCT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.imageUrl.isNotEmpty) {
                            // print(
                            //     'after new image upload new image url ${controller.imageUrl}');
                            // print(
                            //     'PRODUCT DESCRIPTION ${controller.description.text}');
                            controller.updateProduct(product);
                          } else {
                            TLoaders.customToast(
                              message: 'Upload Image!!',
                            );
                          }
                        },
                        child: const Text(
                          'Update Product',
                        ),
                      ),
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
