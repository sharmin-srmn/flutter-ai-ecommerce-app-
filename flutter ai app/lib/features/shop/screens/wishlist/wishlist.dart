import 'package:final_project_shopping_app/common/widgets/Icons/t_circular_icon.dart';
import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/loaders/animation_loader.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:final_project_shopping_app/features/shop/controllers/favourites_controller.dart';
import 'package:final_project_shopping_app/features/shop/screens/home/home.dart';
import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:final_project_shopping_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../navigation_menu.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
        appBar: TAppBar(
          title: Text('Wishlist',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCircularIcon(
                icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                  future: controller.favouriteProduct(),
                  builder: (context, snapshot) {
                    //EMPTY WIDGET
                    final emptyWidget = TAnimationLoaderWidget(
                      text: 'Whoop! Wishlist is Empty ...',
                      animation: TImages.favouriteAnimation,
                      showAction: true,
                      actionText: 'Let\'s add more.',
                      onActionPressed: () =>
                          Get.off(() => const NavigationMenu()),
                    );

                    const loader = TVerticalProductShimmer(
                      itemCount: 6,
                    );
                    final widget = TCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                              product: products[index],
                            ));
                  }),
            ),
          ),
        ));
  }
}
