import 'package:flutter/material.dart';

 mySnackBar(BuildContext context, String title) {
  return SnackBar(
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    content: Text(
      title,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2),
    ),
    duration: const Duration(seconds: 2),
  );
}
