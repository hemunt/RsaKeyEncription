import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rsa_message_encription/LocalStorage/SessionManager.dart';

class GenerateKeyScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString privateKey = "".obs;
  RxString publicKey = "".obs;


  void refreshPage() {
    privateKey.value = "";
    publicKey.value = "";
    SessionManager.setPublicKey("");
    SessionManager.setPrivateKey("");
  }

}