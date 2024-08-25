import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../screens/password_cnfiguration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  ///VARIABLES
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///SEND RESET PASSWORD EMAIL
  sendPasswordResetEmail() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing your request..,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!forgetPasswordFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //FINALLY SEND THE
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS SCREEN
      TLoaders.succesSnackBar(
        title: 'Email sent.',
        message: 'Email Link Sent to Reset your Password.'.tr,
      );

      //REDIRECT
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW ERROR MESSAGE
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  ///SEND RESET PASSWORD EMAIL
  resendPasswordResetEmail(String email) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing your request..,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //FINALLY SEND THE
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS SCREEN
      TLoaders.succesSnackBar(
        title: 'Email sent.',
        message: 'Email Link Sent to Reset your Password.'.tr,
      );
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW ERROR MESSAGE
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
