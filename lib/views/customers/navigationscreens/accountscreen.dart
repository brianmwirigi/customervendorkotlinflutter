import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/loginscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/innerscreens/customereditprofilescreen.dart';
import 'package:customervendorkotlinflutter/views/customers/innerscreens/customerorderscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/cartscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Customers');
    return _auth.currentUser == null
        ? CustomerLogInScreen()
        : FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Center(child: Text('User does not exits'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 5,
                    backgroundColor: Colors.green,
                    title: const Center(
                      child: Text(
                        'PROFILE DETAILS',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    centerTitle: true,
                    actions: const [
                      // darktheme button
                    ],
                  ),
                  body: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.green,
                          backgroundImage:
                              NetworkImage(data['profileImageUrl']),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data['userName'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data['email'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CustomerEditProfileScreen(
                                customerData: data);
                          }));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 200,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Edit Profile',
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          color: Colors.green,
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Phone Number: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['phoneNumber'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        leading: const Icon(Icons.phone_outlined),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'SHOPPING CART',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: const Icon(Icons.shopping_cart_outlined),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CartScreen();
                          }));
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 150,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'ORDERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: const Icon(Icons.shopping_bag_outlined),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CustomerOrderScreen();
                          }));
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 200,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: const Icon(Icons.logout),
                        onTap: () async {
                          await _auth.signOut().whenComplete(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerLogInScreen();
                            }));
                          });
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
  }
}
