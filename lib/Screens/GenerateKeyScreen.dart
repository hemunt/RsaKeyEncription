import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AppConstent/Colors.dart';
import '../Controller/GenerareKeyScreenController.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../LocalStorage/SessionManager.dart';
import '../TextField/AppTextField.dart';

class GenerateKey extends StatefulWidget {
  const GenerateKey({Key? key}) : super(key: key);

  @override
  State<GenerateKey> createState() => _GenerateKeyState();
}

class _GenerateKeyState extends State<GenerateKey> {
  GenerateKeyScreenController  controller =  Get.put(GenerateKeyScreenController());
  @override
  void initState() {
    if(SessionManager.isKeysSet()){
      controller.privateKey.value = SessionManager.getPrivateKey();
      controller.publicKey.value = SessionManager.getPublicKey();
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
                Obx(()=> AppTextField(keyTypeText: "Private Key",value: controller.privateKey.value, fieldData: (val){}, label: "Private Key",)),
                Obx(()=> AppTextField(keyTypeText: "Public Key", value: controller.publicKey.value, fieldData: (val){}, label: "Public Key",)),
                GestureDetector(
                  onTap: (){
                      controller.isLoading.value = true;
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
                        controller.privateKey.value = privateKeyBase64;
                        controller.publicKey.value = publicKeyBase64;
                        controller.isLoading.value = false;
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
                Obx(()=> controller.isLoading.value ? CircularProgressIndicator(color: secondaryColor,) : const SizedBox()),
              ],
            ),
          )
      ),
    );
  }
}
