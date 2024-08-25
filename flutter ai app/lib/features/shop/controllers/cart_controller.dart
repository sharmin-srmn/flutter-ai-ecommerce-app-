import 'package:final_project_shopping_app/common/widgets/login_signup/login_popup_alert.dart';
import 'package:final_project_shopping_app/features/admin_dashboard/models/product_model.dart';
import 'package:final_project_shopping_app/features/shop/models/cart_item_model.dart';
import 'package:final_project_shopping_app/utils/local_storage/storage_utility.dart';
import 'package:final_project_shopping_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  ///VARIABLES
  RxInt noOfCatItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    loadCartItems();
  }

  //ADD ITEMS IN THE CART
  void addToCart(ProductModel product) {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser != null) {
      //QUANTITY CHECK
      if (productQuantityInCart.value < 1) {
        TLoaders.customToast(message: 'Select Quantity');
        return;
      }

      //OUT OF STOCK
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Selected Product is Out of stock',
        );
        return;
      }

      //CONVERT THE PRODUCT MODEL TO A CARTMODEL WITH THE GIVEN QUNATITY
      final selectedCartItem =
          convertToCartItem(product, productQuantityInCart.value);

      int index = cartItems.indexWhere(
          (cartItem) => cartItem.productId == selectedCartItem.productId);
      if (index >= 0) {
        //THIS QUANTITY IS ALREADY ADDED OR UPDATED? REMOVED FROM THE DESIGM(CART)()
        cartItems[index].quantity = selectedCartItem.quantity;
      } else {
        cartItems.add(selectedCartItem);
      }

      updateCart();
      TLoaders.customToast(message: 'Your product has been added to the cart');
    } else {
      Get.to(() => const LoginPopUpAlertScreen());
    }
  }

  //ADD ITEM INTO CART BY TAPPING PLUS
  void addOneItemToCart(CartItemModel item) {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser != null) {
      int index = cartItems
          .indexWhere((cartItem) => cartItem.productId == item.productId);
      if (index >= 0) {
        cartItems[index].quantity += 1;
      } else {
        cartItems.add(item);
      }
      updateCart();
    }
  }

  //REMOVE ITEM INTO CART BY TAPPING PLUS
  void removeOneItemFromCart(CartItemModel item) {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser != null) {
      int index = cartItems
          .indexWhere((cartItem) => cartItem.productId == item.productId);
      if (index >= 0) {
        if (cartItems[index].quantity > 1) {
          cartItems[index].quantity -= 1;
        } else {
          cartItems[index].quantity == 1
              ? removeFromCartDialog(index)
              : cartItems.removeAt(index);
        }
        updateCart();
      }
    }
  }

  //WARNING POPUP BEFORE REMOVING THE LAST ITEM FROM CART
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove thisproducts.',
      onConfirm: () {
        //REMOVE THE ITEM FROM THE CART
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: "Product has been removed from the cart");
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

//CONVERT A PRODUCT MODEL TO A CARTITEMMODEL
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    final price = product.salePrice > 0.0 ? product.salePrice : product.price;
    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      price: price,
      title: product.title,
      image: product.image,
      brandName: product.brand,
    );
  }

//UPDATE CART
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCatItems.value = calculatedNoOfItems;
  }

  //SAve
  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  ///LOAD/FETCH CART ITEMS.
  void loadCartItems() {
    final authUser = AuthenticationRepository.instance.authUser;

    if (authUser != null) {
      final cartItemStrings =
          TLocalStorage.instance().readData<List<dynamic>>('cartItems');
      if (cartItemStrings != null) {
        cartItems.assignAll(cartItemStrings.map(
            (item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
        updateCartTotals();
      }
    }
  }

  int getProductQunatityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  //CLEAR THE CART
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

//INITIALIZE ALREADY ADDED ITEM'S COUNT IN THE CART
  void updateAlreadyAddedProductCount(ProductModel product) {
    productQuantityInCart.value = getProductQunatityInCart(product.id);
  }
}
