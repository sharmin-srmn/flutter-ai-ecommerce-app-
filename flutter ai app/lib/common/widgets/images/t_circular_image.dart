import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_shopping_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../shimmers/shimmer.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.overlayColor,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        //if image background color is null then switch it to light and dark mode color design.
        color: const Color.fromRGBO(81, 84, 67, 1),

        // color: backgroundColor ??
        //     (THelperFunctions.isDarkMode(context)
        //         ? TColors.black
        //         : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  // color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadprogress) =>
                      const TShimmerEffect(
                    width: 55,
                    height: 55,
                    radius: 55,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
