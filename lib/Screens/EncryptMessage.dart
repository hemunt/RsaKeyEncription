import 'package:flutter/material.dart';

import '../AppConstent/Colors.dart';
import '../LocalStorage/SessionManager.dart';
import '../TextField/AppTextField.dart';
class EncryptMessage extends StatefulWidget {
  const EncryptMessage({Key? key}) : super(key: key);

  @override
  State<EncryptMessage> createState() => _EncryptMessageState();
}

class _EncryptMessageState extends State<EncryptMessage> {

  String privateKey = "";
  bool isLoading = false;

  @override
  void initState() {
    if(SessionManager.isKeysSet()){
      privateKey = SessionManager.getPrivateKey();
      }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                AppTextField(keyTypeText: "Write Your Message", isCopy: false, fieldData: (val){}),
                AppTextField(keyTypeText: "Your Private Key",maxLines: 1, fieldData: (val){}, readOnly: true, value: privateKey ??"", isCopy: false,),
                AppTextField(keyTypeText: "Your Encrypted Message", isCopy: true, fieldData: (val){}),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    height: 60,
                    margin:const  EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xffFF5722)
                    ),
                    child: const Center(
                      child: Text(
                        "Encrypt",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                isLoading ? CircularProgressIndicator(color: secondaryColor,) : const SizedBox(),
              ],
            ),
          )
      ),
    );
  }
}
