import 'package:flutter/material.dart';
import 'package:rsa_message_encription/AppConstent/Colors.dart';
import 'package:rsa_message_encription/Screens/DashboardScreen.dart';

import '../LocalStorage/AppStorage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback(
    (_)async{
      await AppStorage.init();
      Future.delayed(Duration(seconds: 1),() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DashboardScreen();
        },));
      },);
    }
  );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/mspy.png", width: 130,),
              SizedBox(
                height: 150,
              ),
              Text("Encryption Spy", style: TextStyle(
                 color: secondaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 42,
              ),),
              SizedBox(
                height: 10,
              ),
              const Text("Message Encryption Tool",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                      child: LinearProgressIndicator(color: secondaryColor,backgroundColor: Colors.transparent,)))
            ],
          ),
        ),
      ),
    );
  }
}
