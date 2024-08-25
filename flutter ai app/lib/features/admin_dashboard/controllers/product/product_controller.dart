import 'package:final_project_shopping_app/data/repositories/product/product_repository.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/screens/product/widgets/all_product.dart';
import 'package:final_project_shopping_app/features/personalization/screens/settings/settings.dart';
import 'package:final_project_shopping_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../../utils/helpers/network_manager.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  ///VARIABLES
  final productRepository = Get.put(ProductRepository());
  //FOR ADD PRODUCTS
  TextEditingController title = TextEditingController();
  TextEditingController productId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController tag = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController stock = TextEditingController();
  RxBool isFeatured = true.obs;
  String imageUrl = '';

  final imageUploading = false.obs;
  final imageDeleting = false.obs;
  final isLoading = false.obs;
  RxBool refreshData = true.obs;
  GlobalKey<FormState> uploadProductFormKey = GlobalKey<FormState>();

  RxList<ProductModel> featuredProducts =
      <ProductModel>[].obs; // THIS WILL HOLD ONLY FEATURED PRODUCTS
  final RxList<ProductModel> allProducts =
      <ProductModel>[].obs; // THIS WILL HOLD ALL PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> newArrivalsProducts =
      <ProductModel>[].obs; // THIS WILL HOLD ALL PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensProducts = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )

  final RxList<ProductModel> mensFeaturedShirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensAllShirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensFeaturedTshirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensAllTshirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensFeaturedPant = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensAllPant = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensFeaturedPanjabi = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> mensAllPanjabi = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )

  final RxList<ProductModel> womensProducts = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL WOMENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensFeaturedSaare = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensAllSaare = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensFeaturedSuit = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensAllSuit = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensFeaturedKurti = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensAllKurti = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensFeaturedTop = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensAllTop = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensFeaturedShirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )
  final RxList<ProductModel> womensAllShirt = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL MENS PRODUCT (NEW, SALE, FEATURED )

  final RxList<ProductModel> tagProducts = <ProductModel>[]
      .obs; // THIS WILL HOLD ALL WOMENS PRODUCT (NEW, SALE, FEATURED )

  @override
  void onInit() {
    fetchFeaturedProducts();
    fetchAllProducts();
    fetchNewArrivalsProducts();
    // fetchMensProducts();

    super.onInit();
  }

  //GET MENS shirt PRODUCTS
  Future<List<ProductModel>> fetchMensShirt(String text) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(text);
      mensAllShirt.assignAll(products);

      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      mensFeaturedShirt.assignAll(featuredproduct);

      return mensAllShirt;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET MENS Tshirt PRODUCTS
  Future<List<ProductModel>> fetchMensTshirt(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      mensAllTshirt.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      mensFeaturedTshirt.assignAll(featuredproduct);

      return mensAllTshirt;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET MENS PANT PRODUCTS
  Future<List<ProductModel>> fetchMensPant(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      mensAllPant.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      mensFeaturedPant.assignAll(featuredproduct);

      return mensAllPant;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET MENS PANJABI PRODUCTS
  Future<List<ProductModel>> fetchMensPanjabi(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      mensAllPanjabi.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      mensFeaturedPanjabi.assignAll(featuredproduct);

      return mensAllPanjabi;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET WOMENS SAARRE PRODUCTS
  Future<List<ProductModel>> fetchWomensSaare(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      womensAllSaare.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      womensFeaturedSaare.assignAll(featuredproduct);

      return womensAllSaare;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET WOMENS SUIT PRODUCTS
  Future<List<ProductModel>> fetchWomensSuit(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      womensAllSuit.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      womensFeaturedSuit.assignAll(featuredproduct);

      return womensAllSuit;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET WOMENS TOP PRODUCTS
  Future<List<ProductModel>> fetchWomensTop(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      womensAllTop.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      womensFeaturedTop.assignAll(featuredproduct);

      return womensAllTop;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET WOMENS KURTI PRODUCTS
  Future<List<ProductModel>> fetchWomensKurti(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      womensAllKurti.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      womensFeaturedKurti.assignAll(featuredproduct);

      return womensAllKurti;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET WOMENS shirt PRODUCTS
  Future<List<ProductModel>> fetchWomensShirt(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      womensAllShirt.assignAll(products);
      // CHECKING IF THE FETCHED PRODUCTS ARE FEATURED AND ASSIGNING THEM INTO mensFeaturedShirt
      List<ProductModel> featuredproduct =
          products.where((product) => product.isFeatured).toList();
      womensFeaturedShirt.assignAll(featuredproduct);

      return womensAllShirt;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET  ALL THE MENS PRODUCTS
  Future<List<ProductModel>> fetchProductsBytagName(String tagName) async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getProductsByTagName(tagName);
      tagProducts.assignAll(products);

      return tagProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET  ALL THE MENS PRODUCTS
  Future<List<ProductModel>> fetchMensProducts() async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getAllMensProducts();
      mensProducts.assignAll(products);

      return mensProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET  ALL THE  WOMENS PRODUCTS
  Future<List<ProductModel>> fetchWomensProducts() async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getAllWomensProducts();
      womensProducts.assignAll(products);

      return womensProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET FEATURED PRODUCTS
  void fetchFeaturedProducts() async {
    try {
      //SHOW LOADER WHILE LOADING PRODUCTDS
      isLoading.value = true;

      //FETCH PRODUCTS
      final products = await productRepository.getFeaturedProducts();

      //ASSIGN FEATURED PRODUCTS
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //GET  ALL THE  FEATURED (TRUE) PRODUCTS
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET  ALL THE   PRODUCTS
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getAllProducts();
      allProducts.assignAll(products);

      return allProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

  //GET  NEW ARRIVALS PRODUCTS
  Future<List<ProductModel>> fetchNewArrivalsProducts() async {
    try {
      //FETCH PRODUCTS
      final products = await productRepository.getAllNewProducts();
      newArrivalsProducts.clear();
      newArrivalsProducts.assignAll(products);
      return newArrivalsProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    }
  }

// //GET THE PRODUCT PRICE
//   String getProductPrice(ProductModel product) {
//     double smallestPrice = double.infinity;
//     double largestPrice = 0.0;
//   }

// CALCULATE DISCOUNT PERCENTAGE
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    //GET THE PERCENTAGE
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // GET THE STOCK STATUS
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // FIRST UPLOAD PRODUCT IMAGE
  uploadProductImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 700,
      maxWidth: 400,
    );

    if (image != null) {
      imageUploading.value = true;
      imageDeleting.value = false;
      //UPLOAD IMAGE
      imageUrl = await productRepository.uploadImage('Products/Images/', image);
      imageUploading.value = false;
    } else {
      TLoaders.errorSnackBar(
          title: 'Oh Snap1',
          message: 'Image upload was unsuccessful or cancelled');
      return;
    }
    imageUploading.value = true;
    return imageUrl;
  }

  // THEN UPLOAD PRODUCT INTO FIREBASE
  Future<void> uploadProduct() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Wait while uploading Product information...,',
          TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!uploadProductFormKey.currentState!.validate()) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // SAVE PRODUCT INFORMATION IN THE FIREBASE FIRESTORE
      if (imageUrl.isNotEmpty) {
        ///FORMATTING DATE
        //FORMATTING CURRENT DATE WILL AUTOMATICCALLY RETURN STRING
        // String formattedDateString = DateFormat.yMMMd().format(DateTime.now());
        // PARSE THE FORMATTED STRING DATE TO CONVERT INTO DATETIME
        // DateTime date = DateFormat.yMMMd().parse(formattedDateString);

        final product = ProductModel(
          id: '',
          isFeatured: isFeatured.value,
          brand: brand.text.trim(),
          tag: tag.text.trim(),
          category: category.text.trim(),
          price: double.parse(price.text.trim()),
          salePrice: double.parse(salePrice.text.trim()),
          image: imageUrl,
          title: title.text.trim(),
          productId: int.parse(productId.text.trim()),
          description: description.text.trim(),
          stock: int.parse(stock.text.trim()),
          date: DateTime.now(),
        );
        await productRepository.saveProductRecord(product);

        //REMOVE LOADER
        TFullScreenLoader.stopLoading();

        //SHOW SUCCESS MESSAGE
        TLoaders.succesSnackBar(
            title: 'Congratulation!',
            message: 'Product has been successfully uploaded.');

        //REFRESH PRODUCT DATA
        refreshData.toggle();

        //REFRESH FIELD
        resetFormFields();

        //MOVE TO PREVIOUS SCREEN
        Navigator.of(Get.context!).pop();
        // Get.off(() => const SettingsScreen());
        Get.offAll(() => const NavigationMenu());
      } else {
        TFullScreenLoader.stopLoading();

        //SHOW SUCCESS MESSAGE
        TLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: 'Select Image for uploading the product information');
        return;
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snappp!!', message: e.toString());
    }
  }

  //UPDATE THE PRODUCT
  Future<void> updateProduct(ProductModel product) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Updating Product information...,', TImages.docerAnimation);
      // print('Product descripotipn ${description}');

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }
      final updatedProduct = ProductModel(
        id: product.id,
        isFeatured: isFeatured.value,
        brand: brand.text.trim(),
        tag: tag.text.trim(),
        category: category.text.trim(),
        price: double.parse(price.text.trim()),
        salePrice: double.parse(salePrice.text.trim()),
        image: imageUrl,
        title: title.text.trim(),
        productId: int.parse(productId.text.trim()),
        description: description.text.trim(),
        stock: int.parse(stock.text.trim()),
      );

      await productRepository.updateProductRecord(updatedProduct);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();
      imageUploading.value = false;

      resetFormFields();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Product has been successfully Updated.');

      //MOVE TO PREVIOUS SCREEN
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //FUNCION TO RESET FORM FIELDS AFTER UPLOADING OR UPDATING PRODUCT INFORMATION
  void resetFormFields() {
    title.clear();
    description.clear();
    price.clear();
    salePrice.clear();
    tag.clear();
    productId.clear();
    brand.clear();
    category.clear();
    stock.clear();
    imageUrl = '';
    uploadProductFormKey.currentState?.reset();
  }

  //WARNING POPUP BEFORE DELETING PRODUCT
  void deleteProductWarningPopup(String productId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Product',
      middleText:
          'Are you sure you want to delete the Product permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteProduct(productId),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //DELETE PRODUCT IMAGE FIRST
  deleteProductImage(String imageUrlToDelete) async {
    try {
      imageDeleting.value = true;
      imageUploading.value = true;

      //DELETING THE PRODUCT IMAGE FROM FIREBASE STORAGE
      if (imageUrlToDelete.isNotEmpty) {
        await productRepository.deleteProductImage(imageUrlToDelete);
        return '';
      }
    } catch (e) {
      imageDeleting.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }

  //THEN DELETING THE PRODUCT INFORMATION
  Future<void> deleteProduct(String productId) async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Deleting Product information...,', TImages.docerAnimation);

      //CHECK INTERNET CONNECTION
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //REMOVE LOADER
        TFullScreenLoader.stopLoading();
        return;
      }

      // FIND THE PRODUCT TO DELETE FROM THEPRODUCT LIST
      final productToDelete =
          allProducts.firstWhere((product) => product.id == productId);

      // GETTING THE IMAGE URL FROM THE PRODUCT INFORMATION
      final String imageUrlToDelete = productToDelete.image;
      // print('$imageUrlToDelete');

      //FIRST DELETING THE PRODUCT IMAGE FROM FIREBASE STORAGE
      await productRepository.deleteProductImage(imageUrlToDelete);

      //DELETING THE PRODUCT INFORMATION FROM FIREBASE STORAGE
      await productRepository.deleteProductRecord(productId);

      allProducts.removeWhere((product) => product.id == productId);
      featuredProducts.removeWhere((product) => product.id == productId);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      //SHOW SUCCESS MESSAGE
      TLoaders.succesSnackBar(
          title: 'Congratulation!',
          message: 'Product has been successfully Deleted.');

      //MOVE TO PREVIOUS SCREEN
      Get.off(() => const TAllProductScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
    }
  }
}
