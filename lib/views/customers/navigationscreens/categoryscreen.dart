import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/innerscreens/productcategoryscreen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _productCategoryStream = FirebaseFirestore.instance
        .collection('Categories')
        .orderBy('categoryName')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text('CATEGORIES',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 4,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productCategoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final categoryData = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductCategoryScreen(
                              categoryData: categoryData,
                            );
                          },
                        ),
                      );
                    },
                    leading: Image.network(
                      categoryData['categoryImage'],
                    ),
                    title: Text(
                      categoryData['categoryName'].toUpperCase(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
