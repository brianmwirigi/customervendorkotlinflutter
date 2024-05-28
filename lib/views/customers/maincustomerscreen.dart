import 'package:customervendorkotlinflutter/views/customers/navigationscreens/accountscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/cartscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/categoryscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/homescreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/searchscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/storescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCustomerScreen extends StatefulWidget {
  const MainCustomerScreen({super.key});

  @override
  State<MainCustomerScreen> createState() => _MainCustomerScreenState();
}

class _MainCustomerScreenState extends State<MainCustomerScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoreScreen(),
    const CartScreen(),
    SearchScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'CATEGORY',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.building_2_fill),
            label: 'STORE',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
