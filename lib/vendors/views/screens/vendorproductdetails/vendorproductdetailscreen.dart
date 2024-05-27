import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({super.key, this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productNutritionValuer = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _productCategoryController.text = widget.productData['productCategory'];
      _productQuantityController.text =
          widget.productData['productQuantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toString();
      _productNutritionValuer.text =
          widget.productData['productNutritionValue'];
      _productDescriptionController.text =
          widget.productData['productDescription'];
    });
  }

  int? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.productData['productName'].toUpperCase(),
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              EasyLoading.showError(
                                  'Product Name cannot be empty');
                            }
                          },
                          controller: _productNameController,
                          decoration: const InputDecoration(
                            labelText: 'Product Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          enabled: false,
                          controller: _productCategoryController,
                          decoration: const InputDecoration(
                            labelText: 'Product Category',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            productQuantity = int.parse(value);
                            if (value.isEmpty) {
                              EasyLoading.showError(
                                  'Product Nutrition Value cannot be empty');
                            }
                          },
                          controller: _productQuantityController,
                          decoration: const InputDecoration(
                            labelText: 'Product Quantity',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            productPrice = int.parse(value);
                            if (value.isEmpty) {
                              EasyLoading.showError(
                                  'Product Nutrition Value cannot be empty');
                            }
                          },
                          controller: _productPriceController,
                          decoration: const InputDecoration(
                            labelText: 'Product Price in kes',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              EasyLoading.showError(
                                  'Product Nutrition Value cannot be empty');
                            }
                          },
                          controller: _productNutritionValuer,
                          decoration: const InputDecoration(
                            labelText: 'Product Nutrition Value',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              EasyLoading.showError(
                                  'Product Description cannot be empty');
                            }
                          },
                          maxLength: 500,
                          maxLines: 8,
                          minLines: 5,
                          controller: _productDescriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Product Description',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  EasyLoading.show(status: 'Updating Product...');
                  if (_productNameController.text.isEmpty ||
                      _productNameController.text == null ||
                      _productCategoryController.text.isEmpty ||
                      _productCategoryController.text == null ||
                      _productQuantityController.text.isEmpty ||
                      _productQuantityController.text == null ||
                      _productPriceController.text.isEmpty ||
                      _productPriceController.text == null ||
                      _productNutritionValuer.text.isEmpty ||
                      _productNutritionValuer.text == null ||
                      _productDescriptionController.text.isEmpty ||
                      _productDescriptionController.text == null) {
                    EasyLoading.dismiss();
                    EasyLoading.showError('Please fill in all fields');
                    return;
                  }

                  EasyLoading.show(status: 'Updating Product...');
                  await _firestore
                      .collection('VendorProducts')
                      .doc(widget.productData.id)
                      .update({
                    'productName': _productNameController.text,
                    'productCategory': _productCategoryController.text,
                    'productQuantity':
                        int.parse(_productQuantityController.text),
                    'productPrice': int.parse(_productPriceController.text),
                    'productNutritionValue': _productNutritionValuer.text,
                    'productDescription': _productDescriptionController.text,
                  });
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess('Product Updated Successfully');
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Center(
                      child: Text(
                        'UPDATE PRODUCT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
