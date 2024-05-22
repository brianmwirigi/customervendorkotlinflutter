import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorAccountScreen extends StatelessWidget {
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: (){},
      child: const Text('Logout'),
    ));
  }
}
