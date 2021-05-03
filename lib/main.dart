import 'package:flutter/material.dart';
import 'package:wallpaper_app/category.dart';
import 'package:wallpaper_app/homePage.dart';
import 'package:wallpaper_app/mainPage.dart';
import 'package:wallpaper_app/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: MainPage(),
    );
  }
}
