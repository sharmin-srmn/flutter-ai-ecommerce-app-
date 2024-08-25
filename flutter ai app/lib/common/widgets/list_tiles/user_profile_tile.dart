import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import 'package:final_project_shopping_app/features/personalization/controllers/user_controller.dart';
import 'package:final_project_shopping_app/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../shimmers/shimmer.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(
        () {
          final networkImage = controller.user.value.profilePicture;
          final image = networkImage.isNotEmpty ? networkImage : TImages.user;

          return controller.imageUploading.value
              ? const TShimmerEffect(
                  height: 80,
                  width: 80,
                  radius: 80,
                )
              : TCircularImage(
                  image: image,
                  width: 60,
                  height: 60,
                  isNetworkImage: networkImage.isNotEmpty,
                );
        },
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .apply(color: Colors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Iconsax.edit, color: Colors.white),
      ),
    );
  }
}
