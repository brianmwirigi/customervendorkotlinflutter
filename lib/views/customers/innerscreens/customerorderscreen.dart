import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formattedDate(date) {
    final outputFormatDate = DateFormat('dd/MM/yyyy');
    final outputDate = outputFormatDate.format(date.toDate());

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
        .collection('CustomerOrders')
        .where('customerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text(
          'ORDERS',
          style: TextStyle(
            color: Colors.green,
            letterSpacing: 2,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }
          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                return Column(
                  children: [
                    ListTile(
                      leading: document['orderStatus'] == true
                          ? const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 30,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.check),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.access_time),
                            ),
                      title: document['orderStatus'] == true
                          ? const Text(
                              'Order Accepted',
                              style: TextStyle(color: Colors.green),
                            )
                          : const Text(
                              'Order Pending',
                              style: TextStyle(color: Colors.red),
                            ),
                      trailing: Text(
                        'Amount: kes ' + document['productPrice'].toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text(
                        'Date: ' + formattedDate(document['orderDate']),
                      ),
                    ),
                    ExpansionTile(
                      title: const Text('Order Details'),
                      subtitle: const Text(
                        'Click to view order details',
                        style: TextStyle(color: Colors.orange),
                      ),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            child: Image.network(
                              document['productImageUrl'][0],
                              fit: BoxFit.fill,
                            ),
                          ),
                          // other properties...

                          title: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'Product Name: ',
                                ),
                                Text(document['productName']),
                              ],
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Quantity: ',
                                    ),
                                    Text(
                                        document['productQuantity'].toString()),
                                  ],
                                ),
                              ),
                              document['orderStatus'] == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            'Delivery Day: ',
                                          ),
                                          Text(formattedDate(
                                              document['scheduleDate'])),
                                        ],
                                      ),
                                    )
                                  : Text(''),
                              ListTile(
                                title: const Text('CUSTOMER DETAILS',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Customer Photo: '),
                                          CircleAvatar(
                                            radius: 30,
                                            child: ClipOval(
                                              child: Image.network(
                                                document['CustomerPhoto'],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Name: '),
                                          Text(document['customerName']),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            'Phone: ',
                                          ),
                                          Text(document['customerPhone']
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text('Address: '),
                                          Text(document['customerAddress']),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
