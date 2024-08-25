import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/update_dob_controller.dart';
import 'package:final_project_shopping_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ChangeDateOfBirth extends StatelessWidget {
  const ChangeDateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateDateOfBirthController());
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change Date of Birth',
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
              key: controller.updateDateOfBirthFormKey,
              child: Column(
                children: [
                  //DATE OF BIRTH FIELD
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: controller.dateOfBirth,
                    validator: (value) =>
                        TValidator.validateEmptyText('Date of Birth', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.dateOfBirth,
                        prefixIcon: Icon(Icons.calendar_month)),
                  ),

                  //SPACE BETWEEN SECTIONS
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.updateDateOfBirth(),
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
