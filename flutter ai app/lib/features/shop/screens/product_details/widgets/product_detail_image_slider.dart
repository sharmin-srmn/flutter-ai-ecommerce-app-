import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_shopping_app/common/widgets/products/cart/favourite_icon/favourite_icon.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../admin_dashboard/models/product_model.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.white : TColors.light,
        child: Stack(
          children: [
            ///BACK ARROW
            TAppBar(
              showBackArrow: true,
              actions: [
                //FAVOURITE ICON
                TFavouriteIcon(
                  productId: product.id,
                )
              ],
            ),
            //Main large Image
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productItemRadius * 2),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
