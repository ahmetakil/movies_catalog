import 'package:flutter/material.dart';
import 'package:movies_catalog/screens/home_page.dart';
import 'package:movies_catalog/screens/movie_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoviesCatalog",

      routes: {'/': (_) => HomePage(), 'movie_picker': (_) => MoviePicker()},
    );
  }
}
