import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/productdetailscreens/storeproductdetailscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorstream =
        FirebaseFirestore.instance.collection('Vendors').snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green,
        title: const Text('STORES',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 4,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final storeData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return StoreProductDetailScreen(
                          storeData: storeData,
                        );
                      }));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(storeData['storeImage']),
                      ),
                      title: Text(storeData['businessName'].toUpperCase()),
                      subtitle: Text(storeData['countryValue']),
                      trailing: Text(storeData['stateValue'].toString()),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
