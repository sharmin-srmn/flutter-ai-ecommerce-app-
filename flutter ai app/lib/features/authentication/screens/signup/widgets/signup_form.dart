import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';
import 'terms_conditions_checkbox.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              //FOR FIRST NAME
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),

              //SPACE BETWEEN INPUT FIELD
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),

              //FOR FIRST NAME
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //USERNAME
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                TValidator.validateEmptyText('UserName', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //EMAIL
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //PHONE NUMBER
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          // //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //PASSWORD
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              // expands: false,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),

          //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // TERM AND CONDITION CHECK BOX
          const TTermsAndConditionsCheckbox(),

          //SPACE BETWEEN INPUT FIELD
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //SIGNUP BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
