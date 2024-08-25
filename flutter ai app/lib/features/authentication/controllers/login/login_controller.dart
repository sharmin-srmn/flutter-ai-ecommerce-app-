import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:final_project_shopping_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/helpers/network_manager.dart';

class LoginController extends GetxController {
  // static LoginController get instance => Get.find();

  ///VARIABLES
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    final rememberMeEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final rememberMePassword = localStorage.read('REMEMBER_ME_PASSWORD');
    if (rememberMeEmail != null) {
      email.text = rememberMeEmail;
    }
    if (rememberMePassword != null) {
      password.text = rememberMePassword;
    }
  }

  /// EMAIL AND PASSWORD SIGN IN
  Future<void> emailAndPasswordSignIn() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Logging you in ..,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //SAVE DATA IF REMEMBER ME IS SELECTED
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.write('REMEMBER_ME_EMAIL', '');
        localStorage.write('REMEMBER_ME_PASSWORD', '');
      }

      //LOGIN USER USING EMAIL AND PASSWORD AUTHENTICATION
      // final userCredentials =
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //REDIRECT
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  // GOOGLE SIGNIN AUTHENTICATION
  Future<void> googleSignIn() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Logging you in via Google Sign in....,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //GOOGLE AUTHENTICATIOn
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);

      // await userController.fetchUserRecord();
      TFullScreenLoader.stopLoading();

      //REDIRECT
      AuthenticationRepository.instance.screenRedirect();

      TLoaders.succesSnackBar(
          title: 'Account Created',
          message: 'You can set your password by using forget password.');
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
