import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../LocalStorage/StorageHelper.dart';

class GenerateKeyScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString privateKey = "".obs;
  RxString publicKey = "".obs;
  StorageHelper SessionManager = StorageHelper();

  void refreshPage() {
    privateKey.value = "";
    publicKey.value = "";
    SessionManager.setPublicKey("");
    SessionManager.setPrivateKey("");
  }

}