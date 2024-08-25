import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TShimmerEffect(
                height: 20,
                width: 30,
                radius: 30,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              TShimmerEffect(height: 20, width: 20),
            ],
          );
        },
      ),
    );
  }
}
