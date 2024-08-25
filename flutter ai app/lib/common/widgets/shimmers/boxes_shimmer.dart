import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class SBoxesShimmer extends StatelessWidget {
  const SBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: TShimmerEffect(height: 150, width: 110)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: TShimmerEffect(height: 150, width: 110)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: TShimmerEffect(height: 150, width: 110)),
          ],
        )
      ],
    );
  }
}
