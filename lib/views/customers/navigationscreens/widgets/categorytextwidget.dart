import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/categoryscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/homeproductwidget.dart';
import 'package:customervendorkotlinflutter/views/customers/navigationscreens/widgets/mainproductwidget.dart';
import 'package:flutter/material.dart';

class CategoryTextWidget extends StatefulWidget {
  @override
  State<CategoryTextWidget> createState() => _CategoryTextWidgetState();
}

class _CategoryTextWidgetState extends State<CategoryTextWidget> {
  String? _selectedCategory;
  bool _viewAll = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('Categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'CATEGORIES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading categories');
              }

              return SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.docs.length) {
                            // If this is the last item, return the "View All" button
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ActionChip(
                                backgroundColor:
                                    _viewAll ? Colors.red : Colors.green,
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory = null;
                                    _viewAll = true;
                                  });
                                },
                                label: const Center(
                                  child: Text(
                                    'VIEW ALL',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ActionChip(
                              backgroundColor: _selectedCategory ==
                                      categoryData['categoryName']
                                  ? Colors.red
                                  : Colors.green,
                              onPressed: () {
                                setState(() {
                                  _selectedCategory =
                                      categoryData['categoryName'];
                                  _viewAll = false;
                                });
                              },
                              label: Center(
                                child: Text(
                                  categoryData['categoryName'].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CategoryScreen();
                        }));
                      },
                      icon: const Center(
                        child: Icon(Icons.arrow_forward, size: 30),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Text(
            'SELECTED CATEGORY',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_viewAll) MainProductWidget(),
          if (!_viewAll && _selectedCategory != null)
            HomeProductWidget(categoryName: _selectedCategory!),
          if (!_viewAll && _selectedCategory == null)
            const Text(
              // New line
              'No category selected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
