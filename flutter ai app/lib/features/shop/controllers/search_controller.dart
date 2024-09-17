import 'dart:io';
import 'package:final_project_shopping_app/features/admin_dashboard/controllers/product/product_controller.dart';
import 'package:final_project_shopping_app/utils/helpers/helper_functions.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import '../../../common/widgets/custom_shapes/containers/bottom_sheet_pick_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/repositories/product/product_repository.dart';
import '../../admin_dashboard/models/product_model.dart';
import '../screens/all_products/all_products.dart';

class HomeSearchController extends GetxController {
  static HomeSearchController get instance => Get.find();

  //VARIABLES
  File? selectedImage;
  String? message = '';
  final productRepository = ProductRepository.instance;

  final searchTagController = TextEditingController();
  bool isLoading = false;

  List<String> nearestNeighbors = [];
  final RxList<ProductModel> similarProducts = <ProductModel>[].obs;

  // POPUP BOTTOM SHEET FOR PICKING IMAGE
  showBottomSheetPickImage(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    Get.bottomSheet(
      const BottomSheetForPickImage(), // Use the widget for bottom sheet content
      backgroundColor: dark ? Colors.black : Colors.white,
      isDismissible: true,
    );
  }

  //IMAGE SELECTING FUNCTION
  void searchByImage({ImageSource source = ImageSource.camera}) async {
    try {
      //START LOADING
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(81, 84, 67, 1)),
              strokeWidth: 4.0, // Adjust thickness if needed
              value: null,
            ),
          );
        },
      );

      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        // Get.back();
        uploadImageInServer();
      } else {
        TLoaders.customToast(message: 'Select Image to search products!');
      }
    } finally {
      // TFullScreenLoader.stopLoading();
      //AFTER CHOOSING THE IMAGE LOADER SHOULD BE APPAER
      Navigator.of(Get.context!).pop();
    }
  }

  //SEND THE SELECTED IMAGE TO THE FLASK SERVER
  uploadImageInServer() async {
    try {
      //START LOADING
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final request = http.MultipartRequest("POST",
          Uri.parse('https://1dee-2404-1c40-bb-f9ab-a019-1e0b-8e33-3388.ngrok-free.app/upload'));

      final headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile('image',
          selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
          filename: selectedImage!.path.split("/").last));
      request.headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 200) {
        http.Response res = await http.Response.fromStream(response);
        final resJson = jsonDecode(res.body);
        message = resJson['message'];
        nearestNeighbors = List<String>.from(resJson['nearest_neighbors']);
        final product = await fetchProductsSimilarToImage(nearestNeighbors);
        Get.to(() => AllProducts(
              title: 'Similar Products',
              sortableTitle: 'Popular',
              futureMethod: Future.value(product),
            ));
      } else {
        // EXACT ERROR WILL CAUGHT
        // final errorBody = await response.stream.bytesToString();
        TLoaders.customToast(
            message: 'Server is down. Please try again later..');
        Navigator.of(Get.context!).pop();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!', message: "Could not process, try again later. ");
      Navigator.of(Get.context!).pop();
    }
  }

  //GET  THE PRODUCTS BASED ON MATCH IDS GETS FROM THE SERVER
  Future<List<ProductModel>> fetchProductsSimilarToImage(
      List<String> productIds) async {
    try {
      //FETCH PRODUCTS
      final products =
          await productRepository.getProductsSimilarToImage(productIds);
      similarProducts.clear();
      similarProducts.assignAll(products);

      return similarProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!!', message: e.toString());
      return [];
    } finally {
      // TFullScreenLoader.stopLoading();
      Navigator.of(Get.context!).pop();
    }
  }

  //SEACRH PRODUCTS BY TEXT
  Future<void> searchProductByText(String searchTag) async {
    try {
      isLoading = true;
      //START LOADING
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(81, 84, 67, 1)),
              strokeWidth: 4.0, // Adjust thickness if needed
              value: null,
            ),
          );
        },
      );
      final products =
          await ProductController.instance.fetchProductsBytagName(searchTag);

      Navigator.of(Get.context!).pop();

      Get.to(() => AllProducts(
            title: searchTag.capitalize!,
            sortableTitle: 'Popular',
            futureMethod: Future.value(products),
          ));
      searchTagController.clear();
    } catch (e) {
      TLoaders.customToast(message: 'Something went wrong ');
      Navigator.of(Get.context!).pop();
    }
  }
}
