import 'package:flutter/material.dart';

import '../AppConstent/Colors.dart';
import 'package:get/get.dart';

import '../LocalStorage/StorageHelper.dart';
import 'DashboardScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) async{
      await StorageHelper.init();
      Future.delayed(const Duration(seconds: 1),() {
        Get.offAll(() => const DashboardScreen());
      },);
    }
  );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/mspy.png", width: 130,),
            const SizedBox(
              height: 20,
            ),
            Text("Encryption Spy", style: TextStyle(
               color: secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),),
            const SizedBox(
              height: 4,
            ),
            const Text("Message Encryption Tool",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),),
            const SizedBox(
              height: 60.0,
            ),
            SizedBox(
              width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                    child: LinearProgressIndicator(color: secondaryColor,backgroundColor: Colors.transparent,)))
          ],
        ),
      ),
    );
  }
}
