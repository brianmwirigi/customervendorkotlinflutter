import 'package:customervendorkotlinflutter/firebase_options.dart';
import 'package:customervendorkotlinflutter/providers/customercartprovider.dart';
import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:customervendorkotlinflutter/vendors/views/authentications/vendorauthenticationscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/authentications/vendorregistrationscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/mainvendorscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/loginscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/authentications/registerscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/maincustomerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CustomerCartProvider();
    }),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Taviraj-semiBold',
      ),
      home: //VendorAuthenticationScreen(),
          //MainVendorScreen(),
          // MainCustomerScreen(),
          CustomerLogInScreen(),
      builder: EasyLoading.init(),
    );
  }
}
