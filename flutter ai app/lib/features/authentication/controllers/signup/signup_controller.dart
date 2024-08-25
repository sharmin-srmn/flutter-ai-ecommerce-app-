// import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/features/authentication/screens/signup/verify_email.dart';
import 'package:final_project_shopping_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final hidePassword = true.obs; // observable for hiding / showing password
  final privacyPolicy = true.obs; // observable for privacyPolicy acceptance
  final email = TextEditingController(); // Controller for email input
  final firstName = TextEditingController(); // Controller for firstName input
  final lastName = TextEditingController(); // Controller for lastName input
  final userName = TextEditingController(); // Controller for userName input
  final password = TextEditingController(); // Controller for password input
  final phoneNumber =
      TextEditingController(); // Controller for phoneNumber input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // form key for form validation
// TFullScreenLoader.openLoadingDialog('We are processing ypur information ....', TImages.docerAnimation);
  // Signup
  void signup() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information..', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!signupFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // PRIVACY POLICY CHECK
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      //REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE USER DATA IN THE FIREBASE
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // SAVE AUTHENTICATION USER DATA IN THE FIREBASE FIRESTORE
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message:
              'Your account has been created successfully! Verify email to continue.');

      //MOVE TO VERIFY EMAIL SCREEN
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
