import 'package:flutter/material.dart';

import '../AppConstent/Colors.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../LocalStorage/SessionManager.dart';
import '../TextField/AppTextField.dart';

class GenerateKey extends StatefulWidget {
  const GenerateKey({Key? key}) : super(key: key);

  @override
  State<GenerateKey> createState() => _GenerateKeyState();
}

class _GenerateKeyState extends State<GenerateKey> {
  bool isLoading = false;
  String? privateKey = "";
  String? publicKey = "";

  @override
  void initState() {
    if(SessionManager.isKeysSet()){
      privateKey = SessionManager.getPrivateKey();
      publicKey = SessionManager.getPublicKey();
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                AppTextField(keyTypeText: "Private Key",value: privateKey ?? "", fieldData: (val){}, label: "Private Key",),
                AppTextField(keyTypeText: "Public Key", value: publicKey ??"", fieldData: (val){}, label: "Public Key",),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed( const Duration(milliseconds: 500), () {
                      RsaKeyHelper rsaKeyHelper = RsaKeyHelper();
                      final pair = rsaKeyHelper.generateKeyPair();
                      final public = pair.publicKey;
                      final private = pair.privateKey;
                      final publicKeyBase64 = rsaKeyHelper.encodePublicKeyToPem(public);
                      final privateKeyBase64 = rsaKeyHelper.encodePrivateKeyToPem(private);
                      SessionManager.setPrivateKey(privateKeyBase64);
                      SessionManager.setPublicKey(publicKeyBase64);
                      setState((){
                        privateKey = privateKeyBase64;
                        publicKey = publicKeyBase64;
                        isLoading = false;
                      });
                    },);
                  },
                  child: Container(
                    height: 60,
                    margin:const EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color:const Color(0xffFF5722)
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
