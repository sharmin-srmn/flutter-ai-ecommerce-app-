import 'package:final_project_shopping_app/features/shop/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/helpers/helper_functions.dart';

class BottomSheetForPickImage extends StatelessWidget {
  const BottomSheetForPickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeSearchController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Select Image From',
              style: Theme.of(context).textTheme.bodySmall!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      if (Get.isBottomSheetOpen ?? false) Get.back();
                      controller.searchByImage(source: ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    color: dark ? Colors.grey : Colors.black,
                  ),
                  Text(
                    'Camera',
                    style: Theme.of(context).textTheme.labelSmall!,
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      if (Get.isBottomSheetOpen ?? false) Get.back();
                      controller.searchByImage(source: ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    color: dark ? Colors.grey : Colors.black,
                  ),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.labelSmall!,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
