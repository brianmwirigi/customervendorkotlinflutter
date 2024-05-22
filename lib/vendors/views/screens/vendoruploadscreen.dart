import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/mainvendorscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/uploadtabscreens/attributetabscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/uploadtabscreens/generaltabscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/uploadtabscreens/imagetabscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/uploadtabscreens/shippingtabscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class VendorUploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4, //tab bar count
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 20,
            backgroundColor: Colors.white,
            title: const Text(
              'UPLOAD PRODUCT',
              style: TextStyle(color: Colors.green),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('General'),
                ),
                Tab(
                  child: Text('Shipping'),
                ),
                Tab(
                  child: Text('Attribute'),
                ),
                Tab(
                  child: Text('Images'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: GeneralTabScreen()),
              Center(child: ShippingTabScreen()),
              Center(child: AttributeTabScreen()),
              Center(child: ImagesTabScreen()),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                EasyLoading.show(status: 'Uploading Product');
                if (_formKey.currentState!.validate()) {
                  //upload product data to firestore

                  final productId = Uuid().v4();
                  await _firestore
                      .collection('VendorProducts')
                      .doc(productId)
                      .set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'productQuantity':
                        _productProvider.productData['productQuantity'],
                    'productCategory':
                        _productProvider.productData['productCategory'],
                    'productDescription':
                        _productProvider.productData['productDescription'],
                    'productScheduleDate':
                        _productProvider.productData['productScheduleDate'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingFee': _productProvider.productData['shippingFee'],
                    'productNutritionValue':
                        _productProvider.productData['productNutritionValue'],
                    'productSizeList':
                        _productProvider.productData['productSizeList'],
                    'productImageUrlList':
                        _productProvider.productData['productImageUrlList'],
                  }).whenComplete(() {
                    EasyLoading.dismiss();
                    mySnackBar(context, 'Product Uploaded');
                    _formKey.currentState!.reset();
                    _productProvider.clearData();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainVendorScreen();
                    }));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                    ),
                  );
                }
              },
              child: const Text(
                'Save Product',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
