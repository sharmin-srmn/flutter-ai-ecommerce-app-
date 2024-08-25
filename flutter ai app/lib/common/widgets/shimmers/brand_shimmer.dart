import 'package:final_project_shopping_app/common/widgets/layouts/grid_layout.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/widgets.dart';

class SBrandShimmer extends StatelessWidget {
  const SBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        mainAxisExtent: 80,
        itemCount: itemCount,
        itemBuilder: (_, __) => const TShimmerEffect(
              height: 80,
              width: 300,
            ));
  }
}
