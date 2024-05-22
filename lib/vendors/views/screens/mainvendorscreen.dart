import 'package:customervendorkotlinflutter/vendors/views/screens/earningscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/editproductscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/vendoraccountscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/vendororderscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/vendoruploadscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    EarningScreen(),
    VendorUploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        //property to store the index of the current page
        //and to change the page on tap
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'EARNINGS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'UPLOAD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'EDIT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'ORDERS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
