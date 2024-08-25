import 'package:final_project_shopping_app/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../screens/profile/profile.dart';
import 'user_controller.dart';

class UpdateGenderController extends GetxController {
  static UpdateGenderController get instance => Get.find();

  //VARIABLES
  final gender = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateGenderFormKey = GlobalKey<FormState>();

  //INIT USER DATA WHEN HOME SCREEEN APPEAR
  @override
  void onInit() {
    initializeGender();
    super.onInit();
  }

  //FETCH USER RECORD
  Future<void> initializeGender() async {
    gender.text = userController.user.value.gender;
  }

  //
  Future<void> updateGender() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!updateGenderFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //UPDATE USER"S FIRST NAME AND LAST NAME IN THE FIREBASE FIRESTORE
      Map<String, dynamic> name = {
        'Gender': gender.text.trim(),
      };
      await userRepository.updateSingleField(name);

      //UPDATE THE RX USER VALUE
      userController.user.value.gender = gender.text.trim();

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCESS SCREEN
      TLoaders.succesSnackBar(
          title: 'Congratulation!!', message: 'Your gender has been updated.');

      //MOVE TO PREVIOUS SCREEN
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
