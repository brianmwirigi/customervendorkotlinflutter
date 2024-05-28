import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/productdetailscreens/productdetailscreen.dart';
import 'package:flutter/material.dart';

//retrieving all products from the database and assigning to view all products
class MainProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('VendorProducts')
        .where('approve', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator(
            color: Colors.green,
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          // If the product stream is empty, display a message
          return const Center(child: Text('No products found'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Center(child: Text('No products found'));
        }

        return Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 200 / 300,
            ),
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailScreen(
                      productData: productData,
                    );
                  }));
                },
                child: Card(
                  child: Column(children: [
                    Container(
                      height: 150,
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
                              productData['productPrice'].toStringAsFixed(0),
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
            },
          ),
        );
      },
    );
  }
}
