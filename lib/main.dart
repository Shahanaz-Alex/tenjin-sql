import 'package:flutter/material.dart';
import 'package:tenjin/login.dart';
import 'package:tenjin/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(), //change it to Login() 
    );
  }
}