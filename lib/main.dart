import 'package:flutter/material.dart';
import 'package:flutter_app/data/category.dart';
import 'package:flutter_app/pages/home.dart';

void main() {
  Category.initCategory();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyNotFound',
      home: MyHomePage(),
    );
  }
}
