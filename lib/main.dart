import 'package:flutter/material.dart';
import 'package:freej/Screens/Loading_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'BalooDa2'),
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: LoadingScreen(),
    );
  }
}
