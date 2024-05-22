import 'package:flutter/widgets.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  //function to get the form data
  getFormData({
    String? productName,
    int? productPrice,
    int? productQuantity,
    String? productCategory,
    String? productDescription,
    DateTime? productScheduleDate,
    List<String>? productImageUrlList,
    bool? chargeShipping,
    int? shippingFee,
    String? productNutritionValue,
    List<String>? productSizeList,
  }) {
    if (productName != null) {
      productData['productName'] = productName;
    }
    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }
    if (productQuantity != null) {
      productData['productQuantity'] = productQuantity;
    }
    if (productCategory != null) {
      productData['productCategory'] = productCategory;
    }
    if (productDescription != null) {
      productData['productDescription'] = productDescription;
    }
    if (productScheduleDate != null) {
      productData['productScheduleDate'] = productScheduleDate;
    }
    if (productImageUrlList != null) {
      productData['productImageUrlList'] = productImageUrlList;
    }
    if (chargeShipping != null) {
      productData['chargeShipping'] = chargeShipping;
    }
    if (shippingFee != null) {
      productData['shippingFee'] = shippingFee;
    }
    if (productNutritionValue != null) {
      productData['productNutritionValue'] = productNutritionValue;
    }
    if (productSizeList != null) {
      productData['productSizeList'] = productSizeList;
    }
    notifyListeners();
  }
  clearData() {
    productData.clear();
    notifyListeners();
  }
}
