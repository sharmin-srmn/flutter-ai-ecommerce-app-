import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'widgets/order_list_items.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: TAppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        ///orders
        child: TOrderListItems(),
      ),
    );
  }
}
