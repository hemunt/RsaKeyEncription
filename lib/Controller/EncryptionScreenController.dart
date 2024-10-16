import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../LocalStorage/StorageHelper.dart';

class EncryptionScreenController  extends GetxController {

  RxString publicKey = "".obs;
  RxBool isLoading = false.obs;
  RxString message = "".obs;
  RxString encryptedMessage = "".obs;
  RxBool showMessageTF = false.obs;
  StorageHelper SessionManager = StorageHelper();

  void refreshPage(){
    encryptedMessage.value  = "";
    message.value = "";
    showMessageTF.value = false;
    publicKey.value = "";
    SessionManager.setMessage("");
  }



}