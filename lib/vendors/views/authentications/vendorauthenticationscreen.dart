import 'package:customervendorkotlinflutter/vendors/views/screens/landingscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/registerscreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class VendorAuthenticationScreen extends StatelessWidget {
  const VendorAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Are you a Customer?'),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CustomerRegisterScreen();
                }));
              },
              child: const Text(
                'Register Here',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
        return const LandingScreen();
      },
    );
  }
}
