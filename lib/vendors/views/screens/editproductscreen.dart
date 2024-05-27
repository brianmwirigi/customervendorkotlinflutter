import 'package:customervendorkotlinflutter/vendors/views/screens/productedittabscreens/publishedproducttabscreen.dart';
import 'package:customervendorkotlinflutter/vendors/views/screens/productedittabscreens/unpublishedproducttabscreen.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: const Text(
            'MANAGE PRODUCTS',
            style: TextStyle(
              color: Colors.green,
              letterSpacing: 2,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'PUBLISHED',
              ),
              Tab(
                text: 'UNPUBLISHED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedProductTabScreen(),
            UnPublishProductTabScreen(),
          ],
        ),
      ),
    );
  }
}
