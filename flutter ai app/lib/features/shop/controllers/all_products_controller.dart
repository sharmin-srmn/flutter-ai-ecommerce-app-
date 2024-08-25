import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../../admin_dashboard/models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  List<ProductModel> originalProducts = [];

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final fetchedProducts = await repository.fetchProductsByQuery(query);
      // Save the original list of products
      originalProducts = fetchedProducts;
      return fetchedProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Function for sorting the products
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    // Decide which list of products to use for sorting
    List<ProductModel> productsToSort;
    if (sortOption == 'Sale') {
      // Filter products for the "Sale" option
      productsToSort = originalProducts
          .where((product) => product.salePrice < product.price)
          .toList();

      // If there are no products on sale, clear the products list and return
    } else {
      // Use the full list of original products for other options
      productsToSort = originalProducts;
    }

    // Apply sorting based on the selected sort option
    switch (sortOption) {
      case 'Name':
        productsToSort.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Higher Price':
        productsToSort.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      case 'Lower Price':
        productsToSort.sort((a, b) => a.salePrice.compareTo(b.salePrice));
        break;
      case 'New Arrivals':
        productsToSort.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      case 'Sale':
        // Products are already filtered, sort them by sale price in descending order
        productsToSort.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      // products.sort((a, b) {
      //   if (b.salePrice > 0) {
      //     return b.salePrice.compareTo(a.salePrice);
      //   } else if (a.salePrice > 0) {
      //     return -1;
      //   } else {
      //     return 1;
      //   }
      // });

      default:
        // Default sorting option by name
        // productsToSort.sort(
        //     (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        // productsToSort.sort((a, b) => a.productId.compareTo(b.productId));
        break;
    }

    // Assign the sorted products to the observable list
    products.assignAll(productsToSort);
  }

  void assignProducts(List<ProductModel> products, String sortableTitle) {
    // Assign products to the 'products' list
    this.products.assignAll(products);
    // Also keep a copy of the original products list for reference
    originalProducts = List.from(products);
    // Default sorting option by name
    sortProducts(sortableTitle);
  }
}
