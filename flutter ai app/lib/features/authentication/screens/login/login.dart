import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithAppBarheight,
          child: Column(
            children: [
              // LOGO, TITEL, SUBTITLE SECTION
              const TLoginHeader(),

              //FORM
              const TLoginForm(),

              //DIVIDER
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

              //SPACE BETWEEN TWO SECTIONS
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //FOOTER FOR SOCIAL ICONS
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
