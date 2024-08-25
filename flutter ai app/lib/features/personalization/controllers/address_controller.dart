import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:final_project_shopping_app/data/repositories/address/address_repository.dart';
import 'package:final_project_shopping_app/utils/helpers/network_manager.dart';
import 'package:final_project_shopping_app/features/personalization/models/address_model.dart';
import 'package:final_project_shopping_app/features/personalization/screens/address/address.dart';
import 'package:final_project_shopping_app/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:final_project_shopping_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  RxBool geoLocation = false.obs;

  Position? currentPosition;

  //GET ALL ADDRESSES
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  //FOR SELECT ADDRESS
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // CLEAR THE SELECTED FIELD
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      // ASSIGN SELECTED ADDRESS

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //Set THE ESLECTED FIELD TO TRUE FOR THE NEWLY SELECTED ADDRESS
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  ///ADD NEW ADDRESS MANUALLY
  Future addNewAddresses() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Storing address..', TImages.docerAnimation);

      //CHECK NETWORK
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!addressFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      //SAVE ADDRESS DATA
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      //UPDATE SELECTED ADDRESS STATUS
      address.id = id;
      selectedAddress(address);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'CONGRATULATIONS',
          message: 'Your Address has been saved successfully.');

      //REFRESH ADDRESSES DATA
      refreshData.toggle();

      //REFRESH FIELD
      resetFormFields();

      //REDIRECT
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(
          title: 'Unable to save User Address!!', message: e.toString());
    }
  }

  //FUNCION TO RESET FORM FIELDS
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

// SELECT NEW ADDRESS POPUP
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(
                title: 'Select Address',
                showActionButton: false,
              ),
              FutureBuilder(
                future: getAllUserAddresses(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Placeholder for loading state
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Placeholder for error state
                  } else {
                    final addresses = snapshot.data;
                    if (addresses != null && addresses.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) => TSingleAddress(
                          address: addresses[index],
                          onTap: () async {
                            await selectAddress(addresses[index]);
                            Get.back();
                          },
                        ),
                      );
                    } else {
                      return const Text(
                          'No addresses found'); // Placeholder for no addresses
                    }
                  }
                },
              ),
              const SizedBox(height: TSizes.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Add New Address'),
                  onPressed: () => Get.to(() => const AddNewAddressScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SHOWING POPUP LETTING USER CHOOSE TO ADD ADDRESS MANUALLY OR AUTOMATICALLY
  void showAddAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AddNewAddressScreen(),
                    ),
                  );
                },
                child: const Text('Add Manually'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _autoFillAddress(context);
                  Get.off(() => const AddNewAddressScreen());
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const AddNewAddressScreen()));
                },
                child: const Text('Add Automatically'),
              ),
            ],
          ),
        );
      },
    );
  }

  //ADD NEW ADDRESS USING LOCATION SERVICE
  Future<Position> _autoFillAddress(BuildContext context) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Please wait a while.', TImages.docerAnimation);

      geoLocation.value = true;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission;
      //IF SERVICE NOT ENABLED
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: 'Please keep your Location on.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location Permission has been denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: 'Location Permission has been denied forever.');
      }

      // IF USER GIVE THE PERMISSION
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      // USE POSITION TO FETCH ADDRESS
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Update form fields with fetched address
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        currentPosition = position;

        //HOLD STREET
        street.text = placemark.street ?? '';
        postalCode.text = placemark.postalCode ?? '';
        country.text = placemark.country ?? '';
        //HOLD CITY NAME
        city.text = placemark.locality ?? '';
        //HOLD THANA
        state.text = placemark.subLocality ?? '';
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        Get.off(() => const UserAddressScreen());

        //HOLD DIVISION NAME
        // state.text = placemark.administrativeArea ?? '';

        // Update other form fields as needed
      }
      // print('Street sublocatity same wari jame amsjid $street');
      // print('COUNTRY bangladesh $country');
      // print('City  dhaka $city');
      // print('Postal  khali $postalCode');
      // print('State surtapur $state');
      // print('Name wari jame masjid $name');
      return position;
    } catch (e) {
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(
          title: 'Failed to save user address!!', message: e.toString());
      rethrow;
    }
  }

  //WARNING POPUP BEFORE DELETING ACCOUNT
  void deleteAddressWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Address',
      middleText:
          'Are you sure you want to delete your address permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteAddress(selectedAddress.value),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  ///DELETE USER ADDRESS
  void deleteAddress(AddressModel address) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Processing to Delete Address', TImages.docerAnimation);

      //FIRST RE AUTHENTICATE USER
      // Get reference to the user's document
      final userDocRef = FirebaseFirestore.instance.collection('Users').doc(
          AuthenticationRepository
              .instance.authUser!.uid); // Replace 'userId' with actual user ID

      // Delete the address from the 'addresses' collection under the user's document
      await userDocRef.collection('Addresses').doc(address.id).delete();

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      Get.off(() => const UserAddressScreen());
    } catch (e) {
      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SOME GENERIC ERROR TO THE USER
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
