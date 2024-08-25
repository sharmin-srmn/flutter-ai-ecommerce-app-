import 'package:final_project_shopping_app/data/repositories/banner/banner_repository.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/banner_model.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../personalization/screens/settings/settings.dart';

class BannerController extends GetxController {
  static BannerController get insance => Get.find();

  ///VARIABLES
  //FOR CAROSOUL
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<BannerModel> allBanners = <BannerModel>[].obs;

  //FOR BANNER IMAGE UPLOAD
  final isActive = true.obs;
  final imageUploading = false.obs;
  GlobalKey<FormState> uploadBannerFormKey = GlobalKey<FormState>();
  String imageUrl = '';
  final bannerRepository = Get.put(BannerRepository());

  @override
  void onInit() {
    fetchBanners();
    fetchAllBanners();
    super.onInit();
  }

  //UPDATE PAGE NAVIGATION BAR
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  // UPLOAD BANNER IMAGE IN FIREBASE STORAGE
  uploadBannerImage() async {
    // try {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 700,
        maxWidth: 400,
        imageQuality: 100);

    if (image != null) {
      imageUploading.value = true;
      //UPLOAD IMAGE
      imageUrl = await bannerRepository.uploadImage('Banners/Images/', image);
      imageUploading.value = false;
    }
    imageUploading.value = true;
  }

  //UPLOAD BANNER INFORMATION FIRESTORE DATABASE
  Future<void> uploadBanner() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Uploading BANNER information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // SAVE BANNER INFORMATIONIN THE FIREBASE FIRESTORE
      if (imageUrl.isNotEmpty) {
        final banner = BannerModel(
          id: UniqueKey().toString(),
          imageUrl: imageUrl,
          active: isActive.value,
        );
        await bannerRepository.saveBannerRecord(banner);

        // Notify BannerController of the new banner
        addBanner(banner);
      }

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      imageUploading.value = false;

      resetFormFields();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Banner has been successfully uploaded.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  // METHOD TO ADD NEW BANNER SO THAT BANNERS>OBS GET INFORMED  ABOUT NEW BANNER
  void addBanner(BannerModel newBanner) {
    banners.add(newBanner);
    allBanners.add(newBanner);
  }

  //FUNCION TO RESET FORM FIELDS
  void resetFormFields() {
    uploadBannerFormKey.currentState?.reset();
  }

  ///FETCH FEATURED BANNERS
  Future<void> fetchBanners() async {
    try {
      //SHOW LOADER WHILE LOAIDNG CATEGORIES
      isLoading.value = true;

      //FETCH BANNERS FROM DATA SOURCE (FIRESTORE, API, ETC)
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //ASSIGNS BANNERS
      this.banners.assignAll(banners);

      //UPDATE CATEGORIES LIST

      //FILTER FEATURED CATEGORIES LIST
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///FETCH ALL THE BANNERS (ACTIVE / NON-ACTIVE)
  Future<void> fetchAllBanners() async {
    try {
      //SHOW LOADER WHILE LOAIDNG CATEGORIES
      isLoading.value = true;

      //FETCH BANNERS FROM DATA SOURCE (FIRESTORE, API, ETC)
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchAllBanners();

      //ASSIGNS BANNERS
      allBanners.assignAll(banners);

      //UPDATE CATEGORIES LIST

      //FILTER FEATURED CATEGORIES LIST
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //UPDATE THE BANNER
  Future<void> updateBanner(BannerModel banner) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Updating BANNER information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      await bannerRepository.updateBannerRecord(banner);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      imageUploading.value = false;

      resetFormFields();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Banner has been successfully Updated.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //WARNING POPUP BEFORE DELETING BANNER
  void deleteBannerWarningPopup(String bannerId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Banner',
      middleText:
          'Are you sure you want to delete the Banner permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteBannerImage(bannerId),
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

  //DELETING THE BANNER
  Future<void> deleteBannerImage(String bannerId) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Deleting BANNER information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FIND THE PRODUCT TO DELETE FROM THEPRODUCT LIST
      final bannerToDelete =
          allBanners.firstWhere((banner) => banner.id == bannerId);

      // GETTING THE IMAGE URL FROM THE PROJECT
      final String imageUrlToDelete = bannerToDelete.imageUrl;

      //DELETING THE PRODUCT IMAGE FROM FIREBASE STORAGE
      await bannerRepository.deleteBannerImage(imageUrlToDelete);

      //DELETING THE BANNER INFORMATION FROM FIREBASE STORAGE
      await bannerRepository.deleteBannerRecord(bannerId);
      if (isActive.value) {
        banners.removeWhere((banner) => banner.id == bannerId);
      }
      allBanners.removeWhere((banner) => banner.id == bannerId);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Banner has been successfully Deleted.');

      //MOVE TO PREVIOUS SCREEN
      Get.off(() => const SettingsScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
