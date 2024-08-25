import 'package:final_project_shopping_app/data/repositories/categories/category_repository.dart';
import 'package:final_project_shopping_app/features/shop/controllers/category_controller.dart';
import 'package:final_project_shopping_app/features/shop/models/category_model.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';

class UploadCategoryController extends GetxController {
  static UploadCategoryController get instance => Get.find();

  //VARIABLES
  final categoryRepository = CategoryRepository.instance;
  final categoryName = TextEditingController();
  final parentCategoryName = TextEditingController();
  final isFeatured = true.obs;
  final imageUploading = false.obs;
  final isLoading = false.obs;
  final imageDeleting = false.obs;

  GlobalKey<FormState> uploadCategoryFormKey = GlobalKey<FormState>();
  String imageUrl = '';
  final RxList<CategoryModel> allCategory = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchAllCategory();
    super.onInit();
  }

// UPLOAD PROFILE IMAGE
  uploadCategoryImage() async {
    // try {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (image != null) {
      //UPLOAD IMAGE
      imageUploading.value = true;
      imageUrl =
          await categoryRepository.uploadImage('Categories/Images/', image);
      imageUploading.value = false;
    }
    imageUploading.value = true;
  }

  //UPLOAD CATEGORY
  Future<void> uploadCategory() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are uploading category information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!uploadCategoryFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // SAVE CATEGORY INFORMATION IN THE FIREBASE FIRESTORE
      if (imageUrl.isNotEmpty) {
        final category = CategoryModel(
          id: '',
          image: imageUrl,
          name: categoryName.text.capitalize!.trim(),
          isFeatured: isFeatured.value,
          parentId: parentCategoryName.text.trim(),
          brand: [],
          tag: '',
        );
        await categoryRepository.saveCategoryRecord(category);
      }

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Category has been successfully uploaded.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  // /UPDATE CATEGORY
  Future<void> updateCategory(String categoryID) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are updating category information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!uploadCategoryFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // SAVE CATEGORY INFORMATION IN THE FIREBASE FIRESTORE
      if (imageUrl.isNotEmpty) {
        final category = CategoryModel(
          id: categoryID,
          image: imageUrl,
          name: categoryName.text.capitalize!.trim(),
          isFeatured: isFeatured.value,
          parentId: parentCategoryName.text.trim(),
          brand: [],
          tag: '',
        );
        await categoryRepository.updateCategoryRecord(category);
      }

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Category has been successfully updated.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  ///FETCH ALL THE CATEGORIES (ACTIVE / NON-ACTIVE)
  Future<void> fetchAllCategory() async {
    try {
      //SHOW LOADER WHILE LOAIDNG CATEGORIES
      isLoading.value = true;

      //FETCH BANNERS FROM DATA SOURCE (FIRESTORE, API, ETC)

      final category = await categoryRepository.getAllCategories();

      //ASSIGNS BANNERS
      allCategory.assignAll(category);

      //UPDATE CATEGORIES LIST

      //FILTER FEATURED CATEGORIES LIST
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //WARNING POPUP BEFORE DELETING BANNER
  void deleteCategoryWarningPopup(String categoryName) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Category',
      middleText:
          'Are you sure you want to delete the Category permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteCategory(categoryName),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //DELETE CATEGORY IMAGE FIRST
  deleteCategoryImage(String imageUrlToDelete) async {
    try {
      imageDeleting.value = true;
      imageUploading.value = true;

      //DELETING THE PRODUCT IMAGE FROM FIREBASE STORAGE
      if (imageUrlToDelete.isNotEmpty) {
        await categoryRepository.deleteCategoryImage(imageUrlToDelete);
        return '';
      }
    } catch (e) {
      imageDeleting.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  //DELETING THE BANNER
  Future<void> deleteCategory(String categoryName) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Deleting Category information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // // FIND THE PRODUCT TO DELETE FROM THEPRODUCT LIST
      final categoryToDelete = allCategory.firstWhere((category) =>
          category.name.toLowerCase() == categoryName.toLowerCase());

      // // GETTING THE IMAGE URL FROM THE PROJECT
      final String imageUrlToDelete = categoryToDelete.image;

      // //DELETING THE PRODUCT IMAGE FROM FIREBASE STORAGE
      await categoryRepository.deleteCategoryImage(imageUrlToDelete);

      // //DELETING THE BANNER INFORMATION FROM FIREBASE STORAGE
      await categoryRepository.deleteCategoryRecord(categoryName);

      allCategory.removeWhere((category) => category.name == categoryName);
      CategoryController.instance.allCategories
          .removeWhere((category) => category.name == categoryName);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Category has been successfully Deleted.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
