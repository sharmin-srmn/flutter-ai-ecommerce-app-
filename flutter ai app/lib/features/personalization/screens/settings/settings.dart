import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:final_project_shopping_app/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:final_project_shopping_app/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/screens/admin_dashboard.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:final_project_shopping_app/features/shop/screens/cart/cart.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),

                  //user profile card
                  TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //Account Settings
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address',
                      onTap: () => Get.to(() => const UserAddressScreen())),

                  TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'Add,remove products and move to checkout',
                      onTap: () => Get.to(() => const CartScreen())),
                  TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Order',
                      subTitle: 'In-progress and completed orders',
                      onTap: () => Get.to(() => const OrderScreen())),
                  const TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account'),
                  const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons'),
                  const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message'),
                  const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle:
                          'Manage data usage and connected accounts accounts'),

                  /// App settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  controller.user.value.role.toLowerCase() == 'admin'
                      ? TSettingsMenuTile(
                          onTap: () =>
                              Get.to(() => const TAdminDashboardScreen()),
                          icon: Iconsax.document_upload,
                          title: 'Load Data',
                          subTitle: 'Upload data to your Firebase')
                      : const SizedBox(),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'GeoLocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  //Logout Button******
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
