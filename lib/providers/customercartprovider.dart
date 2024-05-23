import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/models/customercartattribute.dart';
import 'package:flutter/cupertino.dart';

class CustomerCartProvider with ChangeNotifier {
  final Map<String, CustomerCartAttribute> _cartItems = {};

//enable reference outside this file
  Map<String, CustomerCartAttribute> get getCartItem {
    return _cartItems;
  }

  int get totalCartPrice {
    int total = 0;
    _cartItems.forEach((key, cartItemValue) {
      total += cartItemValue.productPrice * cartItemValue.productQuantity;
    });
    return total;
  }

  void addProductToCart(
    String productId,
    String productName,
    String productCategory,
    List productImageUrl,
    int productQuantity,
    int cartProductQuantity,
    int productPrice,
    String productSize,
    Timestamp scheduleDate,
    String vendorId,
  ) {
    //create a unique keey for each product using both the productid and the size
    String productKey = productId + productSize;
    if (_cartItems.containsKey(productKey)) {
      _cartItems.update(
        productKey,
        (existingCartItem) => CustomerCartAttribute(
          productName: existingCartItem.productName,
          productId: existingCartItem.productId,
          productCategory: existingCartItem.productCategory,
          productImageUrl: existingCartItem.productImageUrl,
          productQuantity: existingCartItem.productQuantity + 1,
          cartProductQuantity: existingCartItem.cartProductQuantity,
          productPrice: existingCartItem.productPrice,
          productSize: existingCartItem.productSize,
          scheduleDate: existingCartItem.scheduleDate,
          vendorId: existingCartItem.vendorId,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productKey,
        () => CustomerCartAttribute(
          productName: productName,
          productId: productId,
          productCategory: productCategory,
          productImageUrl: productImageUrl,
          productQuantity: productQuantity,
          cartProductQuantity: cartProductQuantity,
          productPrice: productPrice,
          productSize: productSize,
          scheduleDate: scheduleDate,
          vendorId: vendorId,
        ),
      );
      notifyListeners();
    }
  }

  void productQuantityIncrement(CustomerCartAttribute cartItem) {
    String productKey = cartItem.productId + cartItem.productSize;
    if (_cartItems.containsKey(productKey)) {
      _cartItems.update(
        productKey,
        (existingCartItem) => CustomerCartAttribute(
          productName: existingCartItem.productName,
          productId: existingCartItem.productId,
          productCategory: existingCartItem.productCategory,
          productImageUrl: existingCartItem.productImageUrl,
          productQuantity: existingCartItem.productQuantity + 1,
          cartProductQuantity: existingCartItem.cartProductQuantity,
          productPrice: existingCartItem.productPrice,
          productSize: existingCartItem.productSize,
          scheduleDate: existingCartItem.scheduleDate,
          vendorId: existingCartItem.vendorId,
        ),
      );
      notifyListeners();
    }
  }

  void productQuantityDecrement(CustomerCartAttribute cartItem) {
    cartItem.decrementQuantity();
    notifyListeners();
  }

  void removeItemFromCart(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
