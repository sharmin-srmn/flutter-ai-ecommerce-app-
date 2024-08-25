import 'dart:convert';

import 'package:final_project_shopping_app/data/repositories/product/product_repository.dart';
import 'package:final_project_shopping_app/utils/local_storage/storage_utility.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../admin_dashboard/models/product_model.dart';
import '../../authentication/screens/login/login.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  ///VARIABLES
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() async {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser != null) {
      // Only initialize favorites for logged-in users
      await TLocalStorage.init(authUser.uid);
      final json = TLocalStorage.instance().readData('favourites');
      if (json != null) {
        final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
        favourites.assignAll(
            storedFavourites.map((key, value) => MapEntry(key, value as bool)));
      }
    }
  }

  bool isUserLoggedIn() {
    // Implement your logic to check if the user is logged in
    // For example, you can use FirebaseAuth or any other authentication mechanism
    // Return true if the user is logged in, false otherwise
    AuthenticationRepository.instance.authUser != null;
    return true; // Placeholder, replace with actual logic
  }

  bool isFavourites(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) async {
    final authUser = AuthenticationRepository.instance.authUser;

    if (authUser != null) {
      await TLocalStorage.init(authUser.uid);
      if (!favourites.containsKey(productId)) {
        favourites[productId] = true;
        saveFavouritesToStorage();
        TLoaders.customToast(message: 'Product has been added to the wishlist');
      } else {
        TLocalStorage.instance().removeData(productId);
        favourites.remove(productId);
        saveFavouritesToStorage();
        favourites.refresh();
        TLoaders.customToast(
            message: 'Product has been removed to the wishlist');
      }
    } else {
      // Handle case where user is not logged in
      TLoaders.customToast(message: 'Please log in to add to favorites');
      // Optionally, you can navigate the user to the login screen
      Get.offAll(() => const LoginScreen());
    }
  }

  void saveFavouritesToStorage() {
    final encodeFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodeFavourites);
  }

  Future<List<ProductModel>> favouriteProduct() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
