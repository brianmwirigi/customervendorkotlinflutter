import 'package:customervendorkotlinflutter/vendors/views/screens/landingscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/registerscreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class VendorAuthenticationScreen extends StatelessWidget {
  const VendorAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
              subtitleBuilder: (context, action) {
                return Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustomerRegisterScreen();
                        }));
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Need A Customer Account?  ',
                          ),
                          Text('Create Account',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                );
              },
              providers: [
                EmailAuthProvider(),
              ]);
        }

        // Render your application if authenticated
        return const LandingScreen();
      },
    );
  }
}
