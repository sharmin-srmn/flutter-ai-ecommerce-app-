import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';

/// A utility class for manging a full screen loader
class TFullScreenLoader {
  ///open a full screen loading dialog with a given text and animation
  /// this method does not return anything

  /// parameters
  /// - text : the text to be displayed in the loading dialog
  /// - animation : the lottie animation to ebbshown
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // use Get.overlayContext for overlay dialog
      barrierDismissible:
          false, // the dialog cant be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, //disable poping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog
  /// this method doesnot return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // close the dialog using the Navigator
  }
}
