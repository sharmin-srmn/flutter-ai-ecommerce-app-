import 'package:final_project_shopping_app/data/repositories/authentication/authentication_repository.dart';
import 'package:final_project_shopping_app/data/repositories/user/user_repository.dart';
import 'package:final_project_shopping_app/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  //VARIABLES
  final profileLoading = false.obs;
  final localStorage = GetStorage();
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  ///FETCH USER RECORD
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  ///SAVE USER RECORD FROM ANY REGISTRATION PROVIDER
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //FEFRESH THE RECORD FIRST AND THEN CHCEK IF USER DATA IS ALREADY STORED. IF NOT, STORED NEW DATA
      await fetchUserRecord();
      //
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //CONVERT NAME TO FIRST AND LAST NAME
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final userName = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');
          //MAP DATA
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : nameParts[1],
            userName: userName,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //SAVE USER DATA
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      //REMOVE LOADER
      // TFullScreenLoader.stopLoading();

      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(
        title: 'Data not saved!',
        message:
            'Something went wrong while saving your information. You can re-save your data in your profile.',
      );
    }
  }

  ///DELETE ACCOUNT WARNING
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
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

  ///DELETE USER ACCOUNT
  void deleteUserAccount() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing to Delete Account', TImages.docerAnimation);

      //FIRST RE AUTHENTICATE USER
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //RE VERIFY AUTH EMAIL
        if (provider == 'google.com') {
          // await auth.signInWithGoogle();
          await auth.reAuthenticateWithGoogle();
          await auth.deleteAccount();

          //REMOVE LOADER
          TFullScreenLoader.stopLoading();

          // Get.offAll(() => const LoginScreen());
          Get.offAll(() => const NavigationMenu());
        } else if (provider == 'password') {
          //REMOVE LOADER
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  //--RE AUTHENTICATE BEFORE DELETING
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing...', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }
      // FORM VALIDATION
      if (!reAuthFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      localStorage.write('REMEMBER_ME_EMAIL', '');
      localStorage.write('REMEMBER_ME_PASSWORD', '');

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // Get.offAll(() => const LoginScreen());
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  // UPLOAD PROFILE IMAGE
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        imageUploading.value = true;
        //UPLOAD IMAGE
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //UPDATE USER IMAGE RECORD
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        //SUCCES MESSAGE
        TLoaders.succesSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!', message: 'Something went wrong : $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
