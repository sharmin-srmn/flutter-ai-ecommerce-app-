import 'package:final_project_shopping_app/data/repositories/categories/category_repository.dart';
import 'package:final_project_shopping_app/features/shop/models/category_model.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:get/get.dart';
//THIS IS FOR SHOWING CATEGORIES IN HOME PAGE

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  ///INSTANCE OF CATEGORY REPOSITIRY
  final _categoryRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  ///LOAD CATEGORY DATA
  Future<void> fetchCategories() async {
    try {
      //SHOW LOADER WHILE LOAIDNG CATEGORIES
      isLoading.value = true;

      //FETCH CATEGORIES FROM DATA SOURCE (FIRESTORE, API, ETC)
      final categories = await _categoryRepository.getAllCategories();

      //UPDATE CATEGORIES LIST
      allCategories.assignAll(categories);

      //FILTER FEATURED CATEGORIES LIST
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .toList());
      // featuredCategories.assignAll(allCategories
      //     .where((category) => category.isFeatured && category.parentId.isEmpty)
      //     .take(10)
      //     .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///LOAD SELECTED CATEGORY

  /// GET CATEGORY OR SUB CATEGORY
}
