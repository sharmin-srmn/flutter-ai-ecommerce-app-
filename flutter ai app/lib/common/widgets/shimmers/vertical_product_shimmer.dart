import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        // height: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //IMAGW
              TShimmerEffect(height: 250, width: 180),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //TEXT
              // TShimmerEffect(height: 15, width: 180),
              // SizedBox(
              //   height: TSizes.spaceBtwItems / 2,
              // ),
              // TShimmerEffect(height: 110, width: 180),
            ],
          ),
        ),
      ),
    );
  }
}
