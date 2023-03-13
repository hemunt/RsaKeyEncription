import 'package:flutter/material.dart';
import 'package:rsa_message_encription/Screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

 const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: SplashScreen()
    );
  }
}


