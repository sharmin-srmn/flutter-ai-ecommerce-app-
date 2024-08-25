import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../loaders/animation_loader.dart';

class LoginPopUpAlertScreen extends StatelessWidget {
  const LoginPopUpAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Center(
            child: TAnimationLoaderWidget(
              text: 'You need to login first',
              animation: TImages.loginPopupAlertAnimation,
              showAction: true,
              actionText: 'Log in',
              onActionPressed: () => Get.off(() => const LoginScreen()),
            ),
          ),
        ),
      ),
    );
  }
}
