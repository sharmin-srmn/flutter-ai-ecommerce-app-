

import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:final_project_shopping_app/utils/device/device_utility.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget  implements PreferredSizeWidget{
  const TTabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark =THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
      isScrollable: true,
      indicatorColor: TColors.primaryColor,
      labelColor: dark? TColors.white :TColors.primaryColor ,
      unselectedLabelColor: TColors.darkGrey,
      ),
      
    );
  }
  @override

  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
  
}