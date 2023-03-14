import 'package:flutter/material.dart';

import '../AppConstent/Colors.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../LocalStorage/SessionManager.dart';
import '../TextField/AppTextField.dart';
class EncryptMessage extends StatefulWidget {
  const EncryptMessage({Key? key}) : super(key: key);

  @override
  State<EncryptMessage> createState() => _EncryptMessageState();
}

class _EncryptMessageState extends State<EncryptMessage> {

  String publicKey = "";
  bool isLoading = false;
  String message = "";
  String encryptedMessage = "";
  bool showMessageTF = false;
  @override
  void initState() {
    if(SessionManager.isKeysSet()){
      publicKey = SessionManager.getPublicKey();
      }
    message = SessionManager.getMessage();

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
                AppTextField(keyTypeText: "Write Your Message",maxLines: 4, isCopy: false,value: message, fieldData: (val){
                  message = val;
                }),
                AppTextField(keyTypeText: "Your Public Key",maxLines: 2, fieldData: (val){}, readOnly: false, value: publicKey, isCopy: false,),
                GestureDetector(
                  onTap: (){
                    RsaKeyHelper rsaKeyHelper = RsaKeyHelper();
                    encryptedMessage = rsaKeyHelper.encrypt(message, rsaKeyHelper.parsePublicKeyFromPem(publicKey));
                    SessionManager.setEncryptedMessage(encryptedMessage);
                    SessionManager.setMessage(message);
                    rsaKeyHelper.decrypt(encryptedMessage, rsaKeyHelper.parsePrivateKeyFromPem(SessionManager.getPrivateKey()));
                    setState(() {
                      showMessageTF = true;
                    });
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
                encryptedMessage != "" && showMessageTF ? AppTextField(keyTypeText: "Your Encrypted Message",label: "Encrypted Message", value: encryptedMessage,isCopy: true, fieldData: (val){}) : SizedBox(),

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
