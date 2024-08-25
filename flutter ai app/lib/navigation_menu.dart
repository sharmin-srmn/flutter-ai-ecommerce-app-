import 'package:final_project_shopping_app/common/widgets/login_signup/login_popup_alert.dart';
import 'package:final_project_shopping_app/features/personalization/screens/settings/settings.dart';
import 'package:final_project_shopping_app/features/shop/screens/wishlist/wishlist.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/authentication/screens/login/login.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/store/store.dart';
import 'utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(
                icon: Icon(Iconsax.profile), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // final screens = [
  //   const HomeScreen(),
  //   const StoreScreen(),
  //   const FavouriteScreen(),
  //   // Container(color: Colors.orange),
  //   // Container(color: Colors.blue)
  //   const SettingsScreen(),
  // ];
  List<Widget> get screens => [
        const HomeScreen(),
        const StoreScreen(),
        (AuthenticationRepository.instance.authUser != null &&
                AuthenticationRepository.instance.authUser!.emailVerified)
            ? const FavouriteScreen()
            : const LoginPopUpAlertScreen(),
        (AuthenticationRepository.instance.authUser != null &&
                AuthenticationRepository.instance.authUser!.emailVerified)
            ? const SettingsScreen()
            : const LoginScreen()
        // Container(color: Colors.orange),
        // Container(color: Colors.blue)
      ];
}
