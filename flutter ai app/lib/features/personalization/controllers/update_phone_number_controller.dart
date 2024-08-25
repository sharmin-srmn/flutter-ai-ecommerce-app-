import 'package:final_project_shopping_app/data/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../screens/profile/profile.dart';
import 'user_controller.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  //VARIABLES
  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  //INIT USER DATA WHEN HOME SCREEEN APPEAR
  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  //FETCH USER RECORD
  Future<void> initializePhoneNumber() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  //
  Future<void> updatePhoneNumber() async {
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
      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //UPDATE USER"S FIRST NAME AND LAST NAME IN THE FIREBASE FIRESTORE
      Map<String, dynamic> name = {
        'PhoneNumber': phoneNumber.text.trim(),
      };
      await userRepository.updateSingleField(name);

      //UPDATE THE RX USER VALUE
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCESS SCREEN
      TLoaders.succesSnackBar(
          title: 'Congratulation!!',
          message: 'Your phone number has been updated.');

      //MOVE TO PREVIOUS SCREEN
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
