import 'package:flutter/material.dart';
import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/images/t_circular_image.dart';
import '../../../../shop/controllers/category_controller.dart';
import 'package:get/get.dart';
import '../../../controllers/upload_category_controller.dart';
import 'edit_category.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    final controller = Get.put(UploadCategoryController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Uploaded Categories',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   showDialog(
        //       context: context,
        //       builder: (context) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       });
        //   // return const AdminPageCategoryShimmer();
        // }

        //OBX TO REACTIVELY UPDATE UI WHEN BANNERSCHANGE
        if (categoryController.allCategories.isEmpty) {
          return const Center(
            child: Text('No Category uploaded yet.'),
          );
        } else {
          // Navigator.of(context).pop();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
            child: ListView.separated(
              itemCount: categoryController.allCategories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final category = categoryController.allCategories[index];
                return ListTile(
                  leading: TCircularImage(
                    image: category.image,
                    width: 50,
                    height: 50,
                    isNetworkImage: true,
                  ),
                  title: Text(
                      category.name), // You can add more details here if needed
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //EDIT ICON FOR BANNER
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Get.to(
                          () => EditCategoryScreen(category: category),
                        ),
                      ),

                      //DELETE ICON FOR BANNER
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteCategoryWarningPopup(category.name);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
