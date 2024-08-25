import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

// class TAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const TAppBar({
//     super.key,
//     this.title,
//     this.actions,
//     this.leadingIcon,
//     this.leadingOnPressed,
//     this.showBackArrow = false,
//   });

//   final Widget? title;
//   final bool showBackArrow;
//   final IconData? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
//       child: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         leading: showBackArrow
//             ? IconButton(
//                 onPressed: () => Get.back(),
//                 icon: Icon(Iconsax.arrow_left,
//                     color: dark ? TColors.grey : TColors.dark))
//             : leadingIcon != null
//                 ? IconButton(
//                     onPressed: leadingOnPressed, icon: Icon(leadingIcon))
//                 : null,
//         title: title,
//         actions: actions,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
// }

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.showDrawerIcon = false, // New parameter for drawer icon
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showDrawerIcon; // New parameter for drawer icon

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading:
            _buildLeading(context, dark), // Use helper function for leading
        title: title,
        actions: actions,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context, bool dark) {
    // Function to handle leading icon logic
    if (showBackArrow) {
      return IconButton(
        onPressed: () => Get.back(),
        icon:
            Icon(Iconsax.arrow_left, color: dark ? TColors.grey : TColors.dark),
      );
    } else if (showDrawerIcon) {
      // If showDrawerIcon is true, add an icon button for opening the drawer
      return IconButton(
        icon: Icon(Icons.menu, color: dark ? TColors.grey : TColors.white),
        onPressed: () {
          // Check the state of the drawer and close or open it accordingly
          ScaffoldState scaffoldState = Scaffold.of(context);
          if (scaffoldState.isDrawerOpen) {
            scaffoldState.closeDrawer();
          } else {
            scaffoldState.openDrawer();
          }
        },
      );
    } else if (leadingIcon != null) {
      return IconButton(
        onPressed: leadingOnPressed,
        icon: Icon(leadingIcon, color: dark ? TColors.grey : TColors.dark),
      );
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
