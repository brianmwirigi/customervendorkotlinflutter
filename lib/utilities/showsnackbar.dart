import 'package:flutter/material.dart';

mySnackBar(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      title,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2),
    ),
    duration: const Duration(seconds: 10),
  ));
}
