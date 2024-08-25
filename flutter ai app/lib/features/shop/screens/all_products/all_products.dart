import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_shopping_app/common/widgets/appbar/appbar.dart';
import 'package:final_project_shopping_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../admin_dashboard/models/product_model.dart';
import '../../controllers/all_products_controller.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    required this.sortableTitle,
    this.query,
    this.futureMethod,
  });

  final String title;
  final String sortableTitle;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    return Scaffold(
      //APPBAR
      appBar: TAppBar(
        title: Text(title),
        showBackArrow: true,
      ),

      //BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                const loader = TVerticalProductShimmer();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loader;
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('No Product found.'),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some thing went wrong with snapshot.'),
                  );
                }

                // PRODUCTS FOUND
                final products = snapshot.data!;

                return TSortableProducts(
                  products: products,
                  sortableTitle: sortableTitle,
                );
              }),
        ),
      ),
    );
  }
}
