import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/providers/customercartprovider.dart';
import 'package:customervendorkotlinflutter/views/customers/innerscreens/customereditprofilescreen.dart';
import 'package:customervendorkotlinflutter/views/customers/maincustomerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductCheckoutScreen extends StatefulWidget {
  const ProductCheckoutScreen({super.key});

  @override
  State<ProductCheckoutScreen> createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CustomerCartProvider _customerCartProvider =
        Provider.of<CustomerCartProvider>(context);

    CollectionReference users =
        FirebaseFirestore.instance.collection('Customers');

    return FutureBuilder(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text('Document does not exist');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                elevation: 5,
                backgroundColor: Colors.green,
                title: const Text(
                  'CHECKOUT',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _customerCartProvider.getCartItem.length,
                      itemBuilder: (context, index) {
                        final cartData = _customerCartProvider
                            .getCartItem.values
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Card(
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Image.network(
                                          cartData.productImageUrl[0],
                                          fit: BoxFit.contain),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Product Name: ',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cartData.productName,
                                                style:
                                                    const TextStyle(fontWeight: FontWeight.bold,),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Category: ',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cartData.productCategory
                                                    .toString(),
                                                style:
                                                    const TextStyle(fontWeight: FontWeight.bold,),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Price: ',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'kes ${cartData.productPrice.toStringAsFixed(0)}',
                                                style:
                                                    const TextStyle(fontWeight: FontWeight.bold,),
                                              ),
                                            ],
                                          ),
                                          const Row(children: [
                                            Text(
                                              'Size: ',
                                              style:
                                                  TextStyle(color: Colors.green),
                                            ),
                                          ]),
                                          OutlinedButton(
                                            onPressed: null,
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.red, width: 2),
                                            ),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  cartData.productSize.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: data['address'] == '' ||
                            data['address'] == null ||
                            data['address'].isEmpty
                        ? InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CustomerEditProfileScreen(
                                    customerData: data);
                              })).whenComplete(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text('ADD ADDRESS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 5,
                                    )),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              EasyLoading.show(status: 'Placing Order');
                              _customerCartProvider.getCartItem
                                  .forEach((key, item) {
                                final orderId = const Uuid().v4();
                                _firestore
                                    .collection('CustomerOrders')
                                    .doc(orderId)
                                    .set({
                                  'orderId': orderId,
                                  'vendorId': item.vendorId,
                                  'customerId': data['customerId'],
                                  'customerName': data['userName'],
                                  'customerEmail': data['email'],
                                  'customerPhone': data['phoneNumber'],
                                  'customerAddress': data['address'],
                                  'CustomerPhoto': data['profileImageUrl'],
                                  'productName': item.productName,
                                  'productCategory': item.productCategory,
                                  'productPrice': item.productPrice,
                                  'productId': item.productId,
                                  'productImageUrl': item.productImageUrl,
                                  'productQuantity': item.productQuantity,
                                  'productSize': item.productSize,
                                  'scheduleDate': item.scheduleDate,
                                  'orderDate': Timestamp.now(),
                                  'orderStatus': false,
                                }).whenComplete(() {
                                  setState(() {
                                    _customerCartProvider.getCartItem.clear();
                                  });
                                  EasyLoading.dismiss();
                                  EasyLoading.showSuccess('Order Placed');
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const MainCustomerScreen();
                                  }));
                                });
                              });
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  ' PLACE ORDER',
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
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        });
  }
}
