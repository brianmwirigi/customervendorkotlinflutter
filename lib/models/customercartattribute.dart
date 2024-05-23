import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CustomerCartAttribute with ChangeNotifier {
  final String productName;
  final String productId;
  final String productCategory;
  final List productImageUrl;
  int productQuantity;
  int cartProductQuantity;
  final int productPrice;
  final String productSize;
  Timestamp scheduleDate;
  final String vendorId;

  CustomerCartAttribute(
      {required this.productName,
      required this.productId,
      required this.productCategory,
      required this.productImageUrl,
      required this.productQuantity,
      required this.cartProductQuantity,
      required this.productPrice,
      required this.productSize,
      required this.scheduleDate,
      required this.vendorId});

  void incrementQuantity() {
    productQuantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    productQuantity--;
    notifyListeners();
  }
}
