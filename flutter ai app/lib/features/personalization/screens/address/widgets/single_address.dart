import 'package:final_project_shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/address_controller.dart';
import 'package:final_project_shopping_app/features/personalization/models/address_model.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
          onTap: onTap,
          child: TRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.md),
            width: double.infinity,
            backgroundColor: selectedAddress
                ? TColors.primaryColor.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                    ? TColors.darkerGrey
                    : TColors.grey,
            margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: Stack(
              children: [
                //THIS ICON IS FOR SELECTION ADDRESS
                Positioned(
                  right: 15,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? TColors.light
                            : TColors.dark
                        : null,
                    size: 18,
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 25,
                  child: selectedAddress
                      ? IconButton(
                          onPressed: () =>
                              controller.deleteAddressWarningPopup(),
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                          ),
                        )
                      : const SizedBox(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //USER NAME WHICH HAS BEEN ADDRED DURING ADDRESS
                      address.name.capitalize!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: TSizes.sm / 2),

                    //USER PHONE NUMBER WHICH HAS BEEN ADDRED DURING ADDRESS
                    Text(address.formattedPhoneNo,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: TSizes.sm / 2),

                    //USER ADDRESS WHICH HAS BEEN ADDRED DURING ADDRESS
                    SizedBox(
                      width: 250,
                      child: Text(
                        address.toString().capitalize!,
                        softWrap: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
