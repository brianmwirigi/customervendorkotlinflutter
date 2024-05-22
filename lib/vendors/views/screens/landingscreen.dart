import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/vendors/models/vendorusermodel.dart';
import 'package:customervendorkotlinflutter/vendors/views/authentications/vendorregistrationscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/mainvendorscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final CollectionReference _vendorStream =
        FirebaseFirestore.instance.collection('Vendors');

    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        }
        if (!snapshot.data!.exists) {
          return VendorRegistrationScreen();
        }

        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);

        if (vendorUserModel.approved == true) {
          return const MainVendorScreen();
        } else {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  vendorUserModel.storeImage.toString(),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                vendorUserModel.businessName.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'your\'e application has been submitted for approval \n you will be granted access to the vendor dashboard once your application has been approved',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,

                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: const Text('Sign Out'))
            ],
          ));
        }
      },
    ));
  }
}
