import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Customers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(child: Text('User does not exits'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 5,
              title: const Text(
                'Profile Account',
                style: TextStyle(color: Colors.green, letterSpacing: 4),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dark_mode,
                    ),
                  ),
                ),
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
                    backgroundImage: NetworkImage(data['profileImageUrl']),
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
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Divider(
                    color: Colors.green,
                    height: 20,
                    thickness: 4,
                    indent: 20,
                    endIndent: 20,
                  )  ,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    'Settings',
                  ),
                  leading: const Icon(Icons.settings_outlined),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'PhoneNumber',
                  ),
                  leading: const Icon(Icons.phone_outlined),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Shopping Cart',
                  ),
                  leading: const Icon(Icons.shopping_cart_outlined),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Orders',
                  ),
                  leading: const Icon(Icons.shopping_bag_outlined),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.green),
                  ),
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
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
