import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:final_project_shopping_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding/onboarding_controller.dart';
import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // CONTROLLER FOR ONBOARDING PAGE TO BE HANDLE
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // HORIZONTAL SCROLLABLE PAGES
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardTitle1,
                subtitle: TTexts.onBoardSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardTitle2,
                subtitle: TTexts.onBoardSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardTitle3,
                subtitle: TTexts.onBoardSubTitle3,
              ),
            ],
          ),

          // SKIP BUTTON
          const OnBoardSkip(),

          //DOT NAVIGATION SMOOTHPAGE INDICATOR
          const OnBoardingDotNavigation(),

          //CIRCULAR BUTTON
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
