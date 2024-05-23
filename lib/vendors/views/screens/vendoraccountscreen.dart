import 'package:customervendorkotlinflutter/vendors/views/authentications/vendorauthenticationscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorAccountScreen extends StatelessWidget {
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  void _logoutUser(BuildContext context) async {
    await _authentication.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VendorAuthenticationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: () => _logoutUser(context),
          child: const Text('Logout'),
        ));
  }
}