import 'package:flutter/material.dart';
import 'TelaCases.dart';
import 'TelaAreas.dart';
import 'TelaGlobal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/TelaCases"         :  (context) => TelaCases(),
        "/TelaAreas"         :  (context) => TelaAreas(),
        "/TelaGlobal"        :  (context) => TelaGlobal(),
      },
      title: 'Corona Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new TelaCases(),
    );
  }
}
