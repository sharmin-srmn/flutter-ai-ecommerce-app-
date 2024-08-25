import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/update_phone_number_controller.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      ///CUSTOM APPBAR
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change Phone Number',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADING
            Text(
              'Authenticate Phone Number',
              style: Theme.of(context).textTheme.labelMedium,
            ),

            //SPACE BETWEEN SECTIONS
            const SizedBox(height: TSizes.spaceBtwSections),

            //TEXT FIELD AND BUTTONS
            Form(
              key: controller.updatePhoneNumberFormKey,
              child: Column(
                children: [
                  //FIRST NAME FIELD
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumber,
                    validator: (value) =>
                        TValidator.validateEmptyText('Phone Number', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Icons.phone)),
                  ),

                  //SPACE BETWEEN SECTIONS
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.updatePhoneNumber(),
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
