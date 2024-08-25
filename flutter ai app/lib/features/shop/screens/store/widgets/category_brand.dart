// import 'package:final_project_shopping_app/features/shop/controllers/brand_controller.dart';
import 'package:final_project_shopping_app/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
// import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
// import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../controllers/brand_controller.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    // final brandController = BrandController.instance;

    // return FutureBuilder(
    //     future: brandController.fetchBrandsByCategoryName(category.name),
    //     builder: (context, snapshot) {
    //       const loader = Column(
    //         children: [
    //           SListTileShimmer(),
    //           SizedBox(
    //             height: TSizes.spaceBtwItems,
    //           ),
    //           SBoxesShimmer(),
    //           SizedBox(
    //             height: TSizes.spaceBtwItems,
    //           )
    //         ],
    //       );
    //       final widget = TCloudHelperFunction.checkMultiRecordState(
    //           snapshot: snapshot, loader: loader);
    //       if (widget != null) return widget;

    //       final brandname = snapshot.data!;

    // return ListView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: brandname.length,
    //   itemBuilder: (_, index) {
    //     final brand = brandname[index]['brand'];
    return const TBrandShowcase(
      brand: ' ',
      images: [
        TImages.productImage5,
        TImages.productImage6,
        TImages.productImage7
      ],
    );
    // },
    // );
    // });
  }
}
