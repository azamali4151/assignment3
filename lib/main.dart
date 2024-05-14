import 'package:flutter/material.dart';
import 'package:second_project/home_screen.dart';

void main() {
  runApp(CartApp());
}

class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

