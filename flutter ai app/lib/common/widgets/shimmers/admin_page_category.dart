import 'package:final_project_shopping_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class AdminPageCategoryShimmer extends StatelessWidget {
  const AdminPageCategoryShimmer({super.key, this.itemCount = 15});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.vertical,
          separatorBuilder: (_, __) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (_, __) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TShimmerEffect(
                  height: 60,
                  width: 60,
                  radius: 30,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
