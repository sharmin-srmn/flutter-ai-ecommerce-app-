
import 'package:final_project_shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_price_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/product_title_text.dart';
import 'package:final_project_shopping_app/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Column(
      children: [
        /// Selected Attributes Pricing & Description
       TRoundedContainer(
         padding: const EdgeInsets.all(TSizes.md),
         backgroundColor: dark ? TColors.darkerGrey :TColors.grey,
         child:  Column(
           children: [

             ///Title ,price and Stock Status
             Row(
               children: [
                const  TSectionHeading(title: 'Variation',showActionButton: false),
                const  SizedBox(width: TSizes.spaceBtwItems),

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Row(
                       children: [
                         const TProductTitleText(title: 'Price: ',smallSize: true),

                         ///Actual Price
                         Text(
                           '\$25',
                           style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),

                         ),
                         const SizedBox(width: TSizes.spaceBtwItems),

                         ///Sale price
                         const TProductPriceText(price: '20'),

                       ],
                     ),
                      ///Stock
                     
                     Row(
                       children: [
                         const TProductTitleText(title: 'Price: ',smallSize: true),
                         Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
                       ],
                     ),
                   ],
                 ),

               ],
             ),

             ///Variation Description
             const TProductTitleText(
                 title:'This is the Description of the Product and it can go up to max 4 lines.',
                 smallSize: true,
               maxLines: 4,
             ),
           ],
         ),
       ),
        const SizedBox(height: TSizes.spaceBtwItems),

        ///Attributes

         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors'),
            const SizedBox(height: TSizes.spaceBtwItems /2),
           Wrap(
             spacing: 8,
             children: [
               TChoiceChip(text: 'Black', selected: false,onSelected: (value){}),
               TChoiceChip(text: 'Blue', selected: true,onSelected: (value){}),
               TChoiceChip(text: 'Red', selected: false,onSelected: (value){}),
             //   TChoiceChip(text: 'Green', selected: false,onSelected: (value){}),
             //   TChoiceChip(text: 'Blue', selected: true,onSelected: (value){}),
             //   TChoiceChip(text: 'Purple', selected: false,onSelected: (value){}),
             //   TChoiceChip(text: 'Green', selected: false,onSelected: (value){}),
             //   TChoiceChip(text: 'Blue', selected: true,onSelected: (value){}),
             //   TChoiceChip(text: 'Purple', selected: false,onSelected: (value){}),
             //
              ],
           )


          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size'),
            const SizedBox(height: TSizes.spaceBtwItems /2),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(text: 'EU 34', selected: true,onSelected: (value){}),
              TChoiceChip(text: 'EU 36', selected: false,onSelected: (value){}),
              TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){}),
              // TChoiceChip(text: 'EU 34', selected: true,onSelected: (value){}),
              // TChoiceChip(text: 'EU 36', selected: false,onSelected: (value){}),
              // TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){}),
              // TChoiceChip(text: 'EU 34', selected: true,onSelected: (value){}),
              // TChoiceChip(text: 'EU 36', selected: false,onSelected: (value){}),
              // TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){}),

            ],
          )

          ],
        ),
      ],

    );
  }
}

