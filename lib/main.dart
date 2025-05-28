import 'package:flutter/material.dart';
import 'package:ia_training_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FashApp Training",
      home: HomePage(),
      color: Colors.white,
    );
  }
}
