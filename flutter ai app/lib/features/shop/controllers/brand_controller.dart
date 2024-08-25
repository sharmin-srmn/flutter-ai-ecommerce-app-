import 'package:final_project_shopping_app/data/repositories/product/product_repository.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/brand/brand_repository.dart';
import '../../admin_dashboard/models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  //VARIABLES
  RxBool isLoading = true.obs;
  final RxList<String> allBrands = <String>[].obs;
  final RxList<Map<String, dynamic>> brandsByCategoryName =
      RxList<Map<String, dynamic>>([]);

  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    fetchAllBrands();
    // fetchBrandsByCategoryName('men');
    super.onInit();
  }

  //FETCH ALL BRANDSNAME AVAILABLE
  Future<void> fetchAllBrands() async {
    try {
      //START LOADING
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      isLoading.value = false;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //FETCH ALL PRODUCTS BASED ON BRAND NAME
  Future<List<ProductModel>> fetchBrandProducts(String brandName) async {
    try {
      final products =
          await ProductRepository.instance.getProductsByBrandName(brandName);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //FETCH BRAND BY CATEGORY NAME
  Future<List<Map<String, dynamic>>> fetchBrandsByCategoryName(
      String categoryName) async {
    try {
      // START LOADING
      isLoading.value = true;

      final brands =
          await brandRepository.getBrandsByCategoryName(categoryName);
      brandsByCategoryName.assignAll(brands);
      // print(brandsByCategoryName[0]);
      // print(brandsByCategoryName[1]);
      return brandsByCategoryName;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }
}
