import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/productdetailscreens/productdetailscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreProductDetailScreen extends StatelessWidget {
  final dynamic storeData;

  const StoreProductDetailScreen({super.key, this.storeData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storeproductstream = FirebaseFirestore.instance
        .collection('VendorProducts')
        .where('approve', isEqualTo: true)
        .where('vendorId', isEqualTo: storeData['vendorId'])
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.green,
          title: Text(storeData['businessName'].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 4,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _storeproductstream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No products available',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center),
              );
            }
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 200 / 300),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(
                          productData: productData,
                        );
                      }));
                    },
                    child: Card(
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                productData['productImageUrlList'][0],
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(productData['productName'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              //concatenation of product price and currency
                              'kes' +
                                  ' ' +
                                  productData['productPrice']
                                      .toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                letterSpacing: 2,
                              )),
                        ),
                      ]),
                    ),
                  );
                });
          },
        ));
  }
}
