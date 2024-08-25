import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';

class THomeAppBar extends SliverPersistentHeaderDelegate {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromRGBO(81, 84, 67, 1),
      child: TAppBar(
        showDrawerIcon: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              TTexts.homeAppBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: TColors.grey),
            ),
            Obx(
              () {
                if (controller.profileLoading.value) {
                  return const TShimmerEffect(height: 15, width: 80);
                } else {
                  return Text(
                    (controller.user.value.fullName == ' ')
                        ? "Welcome"
                        : controller.user.value.fullName,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: TColors.white,
                        ),
                  );
                }
              },
            ),
          ],
        ),
        actions: const [
          TCartCounterIcon(
            iconColor: TColors.white,
            counterBgColor: TColors.black,
            counterTextColor: TColors.white,
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight + 50;

  @override
  double get minExtent => kToolbarHeight + 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
