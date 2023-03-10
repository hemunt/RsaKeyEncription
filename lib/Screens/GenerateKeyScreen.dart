import 'package:flutter/material.dart';

import '../TextField/AppTextField.dart';

class GenerateKey extends StatelessWidget {
  const GenerateKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff009688),
        elevation: 0,
        title: const Text("Generate Key",style: TextStyle(
          fontWeight: FontWeight.w400,
        )),
        actions: const [
          Icon(Icons.more_vert),
        ],
        leading:const  Icon(Icons.arrow_back),

      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                const AppTextField(keyTypeText: "Private Key",),
                const AppTextField(keyTypeText: "Public Key",),
                GestureDetector(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffFF5722)
                    ),
                    child: const Center(
                      child: Text(
                        "GENERATE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
