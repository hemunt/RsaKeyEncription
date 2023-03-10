import 'package:flutter/material.dart';

import '../AppConstent/Colors.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Size? screenSize;
  double? width;
  double? height;
@override
  void initState() {
  screenSize = WidgetsBinding.instance.window.physicalSize;
  width = screenSize?.width;
  super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text("",style: TextStyle(
          fontWeight: FontWeight.w400,
        )),
        actions: const [
          Icon(Icons.more_vert),
        ],
        leading:const  Icon(Icons.menu),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4 + 30,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: primaryColor,
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 0,
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: secondaryColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )
      ),
    );
  }
}
