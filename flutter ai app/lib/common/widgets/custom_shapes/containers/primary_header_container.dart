import 'package:final_project_shopping_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:final_project_shopping_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../curved_edges/curved_edges_widget.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: const Color.fromRGBO(81, 84, 67, 1),

        ///[size.isFinite':  is not true] Error -> read README.md file at[DESIGN ERRORS] #1
        child: Stack(
          children: [
            //Background Customs Shapes
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),

            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
