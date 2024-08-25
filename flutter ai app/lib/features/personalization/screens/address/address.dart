import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/address_controller.dart';
import 'package:final_project_shopping_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                //
                final response = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => TSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectedAddress(addresses[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),

      //BOTTOM PLUS ISON FOR ADDING NEW ADDRESS WHICH REDIRECT TO ADD ADDRESS SCREEN
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primaryColor,
        // onPressed: () => Get.to(() => const AddNewAddressScreen()),
        onPressed: () => controller.showAddAddressDialog(context),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
    );
  }
}
