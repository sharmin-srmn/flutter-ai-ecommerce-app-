import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/update_gender_controller.dart';

class ChangeGender extends StatelessWidget {
  const ChangeGender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGenderController());
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change Gender',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADING

            //SPACE BETWEEN SECTIONS
            const SizedBox(height: TSizes.spaceBtwSections),

            //TEXT FIELD AND BUTTONS
            Form(
              key: controller.updateGenderFormKey,
              child: Column(
                children: [
                  //FIRST NAME FIELD
                  TextFormField(
                    controller: controller.gender,
                    validator: (value) =>
                        TValidator.validateEmptyText('Gender', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.gender,
                        prefixIcon: Icon(Iconsax.personalcard)),
                  ),

                  //SPACE BETWEEN SECTIONS
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.updateGender(),
                      child: const Text(
                        'Save',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
