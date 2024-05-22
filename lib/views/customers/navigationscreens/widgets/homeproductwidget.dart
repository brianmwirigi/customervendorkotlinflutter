import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/productdetailscreens/productdetailscreen.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatelessWidget {
  final String categoryName;

  const HomeProductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('VendorProducts')
        .where('productCategory', isEqualTo: categoryName)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const  LinearProgressIndicator(
            color: Colors.green,
          );
        }
        return Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
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

                // This is a placeholder. Replace this with your actual widget
              },
              separatorBuilder: (context, _) => const SizedBox(
                    width: 10,
                  ),
              itemCount: snapshot.data!.docs.length),
        );
      },
    );
  }
}
