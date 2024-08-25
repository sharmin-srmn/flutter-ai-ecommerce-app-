import 'package:final_project_shopping_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/category_controller.dart';

class TDrawer extends StatelessWidget {
  const TDrawer({
    super.key,
    required this.categoryController,
  });
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //DRAWER HEADER
          DrawerHeader(
            child: TSectionHeading(
              title: 'Categories',
              showActionButton: false,
              textColor: dark ? Colors.white : Colors.black,
            ),
          ),

          //ALL CATEGORIES
          Expanded(
              child: THomeCategories(
            categoryController: categoryController,
          )),

          ///SPACE
          const SizedBox(height: TSizes.spaceBtwSections),

          //DIVIDER
          const Divider(),
        ],
      ),
    );
  }
}
