import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../AppConstent/Colors.dart';
import '../Controller/EncryptionScreenController.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../LocalStorage/SessionManager.dart';
import '../TextField/AppTextField.dart';
class EncryptMessage extends StatefulWidget {
  const EncryptMessage({Key? key}) : super(key: key);

  @override
  State<EncryptMessage> createState() => _EncryptMessageState();
}

class _EncryptMessageState extends State<EncryptMessage> {
  EncryptionScreenController controller = Get.put(EncryptionScreenController());

  @override
  void initState() {
    if(SessionManager.isKeysSet()){
      controller.publicKey.value = SessionManager.getPublicKey();
      }
    controller.message.value = SessionManager.getMessage();

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
                Obx(
                  ()=> AppTextField(keyTypeText: "Write Your Message",maxLines: 4, isCopy: false,value: controller.message.value, fieldData: (val){
                    controller.message.value = val;
                  }),
                ),
                Obx(()=>AppTextField(keyTypeText: "Your Public Key",maxLines: 2, fieldData: (val){}, readOnly: false, value: controller.publicKey.value, isCopy: false,)),
                GestureDetector(
                  onTap: (){
                    if(controller.message.value == ""){
                      final snackBar = SnackBar(
                        backgroundColor: secondaryColor,
                        content: const Text("Make sure to fill message field", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'Ok',
                          onPressed: () {
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if(controller.publicKey.value == ""){
                      final snackBar = SnackBar(
                        backgroundColor: secondaryColor,
                        content: const Text("Make sure to add Public Key to Encrypt", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                        action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'Ok',
                          onPressed: () {
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      RsaKeyHelper rsaKeyHelper = RsaKeyHelper();
                      controller.encryptedMessage.value = rsaKeyHelper.encrypt(controller.message.value, rsaKeyHelper.parsePublicKeyFromPem(controller.publicKey.value));
                      SessionManager.setEncryptedMessage(controller.encryptedMessage.value);
                      SessionManager.setMessage(controller.message.value);
                      rsaKeyHelper.decrypt(controller.encryptedMessage.value, rsaKeyHelper.parsePrivateKeyFromPem(SessionManager.getPrivateKey()));
                      setState(() {
                        controller.showMessageTF.value = true;
                      });
                    }
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
                Obx( ()=> controller.encryptedMessage.value != "" && controller.showMessageTF.value ? AppTextField(keyTypeText: "Your Encrypted Message",label: "Encrypted Message", value: controller.encryptedMessage.value,isCopy: true, fieldData: (val){}) : const SizedBox()),

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
