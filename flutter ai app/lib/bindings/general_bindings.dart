import 'package:final_project_shopping_app/features/personalization/controllers/address_controller.dart';
import 'package:get/get.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
  }
}
