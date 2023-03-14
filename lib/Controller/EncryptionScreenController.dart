import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rsa_message_encription/LocalStorage/SessionManager.dart';

class EncryptionScreenController  extends GetxController {

  RxString publicKey = "".obs;
  RxBool isLoading = false.obs;
  RxString message = "".obs;
  RxString encryptedMessage = "".obs;
  RxBool showMessageTF = false.obs;

  void refreshPage(){
    encryptedMessage.value  = "";
    message.value = "";
    showMessageTF.value = false;
    publicKey.value = "";
    SessionManager.setMessage("");
  }



}