import 'package:final_project_shopping_app/common/widgets/login_signup/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TITLE
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              // SPACE BETWEEN TITLE AND FORM
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //SIGN UP FORM
              const TSignupForm(),

              // SPACE BETWEEN INPUT FIELD
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //DIVIDER
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),

              // SPACE BETWEEN INPUT FIELD
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //SOCIAL BUTTONS
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
