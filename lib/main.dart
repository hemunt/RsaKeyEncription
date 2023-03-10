import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rsa_message_encription/Screens/DashboardScreen.dart';

import 'TextField/AppTextField.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

 const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: DashboardScreen()
    );
  }
}


