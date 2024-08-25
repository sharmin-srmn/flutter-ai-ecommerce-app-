import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/category_model.dart';
import 'category_brand.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///CATEGORY AND BRAND
                CategoryBrand(
                  category: category,
                ),

                //SPACE
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Products MIGHT LIKE SECTION
                TSectionHeading(title: 'You might like', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems),

                // TGridLayout(
                //     itemCount: 4,
                //     itemBuilder: (_, index) => const TProductCardVertical()),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ]);
  }
}
