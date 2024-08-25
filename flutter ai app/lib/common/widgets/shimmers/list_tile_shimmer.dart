import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class SListTileShimmer extends StatelessWidget {
  const SListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerEffect(
              height: 50,
              width: 50,
              radius: 50,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Column(
              children: [
                TShimmerEffect(height: 15, width: 100),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEffect(height: 12, width: 80),
              ],
            ),
          ],
        )
      ],
    );
  }
}
