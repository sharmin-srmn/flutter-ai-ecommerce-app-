

import 'package:final_project_shopping_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:final_project_shopping_app/common/widgets/products/rating/rating_indicator.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

         Row(
           children: [
            const CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage1)),
             const SizedBox(width: TSizes.spaceBtwItems),
             Text('Janvi Islam',style: Theme.of(context).textTheme.titleLarge),
           ],
         ),
         IconButton(onPressed: () {}, icon: const Icon (Icons.more_vert)),

       ],
    ),
    const SizedBox(height: TSizes.spaceBtwItems),


    /// Review
         Row(
           children: [
             const TRatingBarIndicator(rating: 4),
             const SizedBox(height: TSizes.spaceBtwItems),
             Text('01,Nov,2023',style: Theme.of(context).textTheme.bodyMedium),
           ],
         ),
         const SizedBox(height: TSizes.spaceBtwItems),
         const ReadMoreText(
           'The user interface of the app is quite intuitive.I was able to navigate and make purchases seamlessly.Great Job!',
            trimLines:2,
           trimMode:TrimMode.Line,
           trimExpandedText:'show less',
           trimCollapsedText: 'show more',
           moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primaryColor),
           lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primaryColor),



         ),
         const SizedBox(height: TSizes.spaceBtwItems),

         ///Company Review

         TRoundedContainer(
           backgroundColor: dark? TColors.darkerGrey: TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("S's Store",style:Theme.of(context).textTheme.titleMedium),
                    Text('2,Nov,2023',style:Theme.of(context).textTheme.bodyMedium),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems),
                const ReadMoreText(
                  'The user interface of the app is quite intuitive.I was able to navigate and make purchases seamlessly.Great Job!',
                  trimLines:2,
                  trimMode:TrimMode.Line,
                  trimExpandedText:'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primaryColor),
                  lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primaryColor),



                ),
              ],
            ),
          ),
         ),
       const SizedBox(height: TSizes.spaceBtwSections),
  ],
    );
  }
}