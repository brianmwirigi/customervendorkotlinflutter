import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for products',
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                CupertinoIcons.search,
                weight: 10,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
