import 'package:flutter/material.dart';
import 'package:rsa_message_encription/Screens/SplashScreen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

 const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner:  false,
      home: SplashScreen()
    );
  }
}



