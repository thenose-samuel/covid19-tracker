import 'package:covid19_tracker/pages/about.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PoppinsRegular'),
      title: 'Covid-19 Tracker',
      home: Home(),
    );
  }
}
