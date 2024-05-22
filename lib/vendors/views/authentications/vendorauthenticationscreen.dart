import 'package:customervendorkotlinflutter/vendors/views/screens/landingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class VendorAuthenticationScreen extends StatefulWidget {
  const VendorAuthenticationScreen({super.key});

  @override
  State<VendorAuthenticationScreen> createState() =>
      _VendorAuthenticationScreenState();
}

class _VendorAuthenticationScreenState
    extends State<VendorAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        return const LandingScreen();
      },
    );
  }
}
