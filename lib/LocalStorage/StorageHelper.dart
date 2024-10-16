// import 'package:get_storage/get_storage.dart';
class StorageHelper {


  static const String _privateKey = "PRIVATE_KEY_2048";
  static const String _publicKey = "PUBLIC_KEY_2048";
  static const String _encryptdMessage = "ENCRYPTED_MESSAGE";
  static const String _Message = "ENCRYPTED_MESSAGE";

  static final StorageHelper _singleton = StorageHelper._internal();
  StorageHelper._internal();

  static Future init() async {
    // var result = await GetStorage.init();
    // print("GetStorageIsIntilized$result");
  }

  factory StorageHelper() {
    return _singleton;
  }

  _savePref(String key, Object? value) async {
    // var prefs = GetStorage();
    // prefs.write(key, value);
  }

  T _getPref<T>(String key) {
    return "" as T;
    // return GetStorage().read(key) as T;
  }

  void clearAll() {
    // GetStorage().erase();
  }


  setMessage(String message) {
    _savePref(_Message, message);
  }


  String getMessage() {
    return _getPref(_Message) ?? "";
  }

  setEncryptedMessage(String message) {
    _savePref(_encryptdMessage, message);
  }


  String getEncryptedMessage() {
    return _getPref(_encryptdMessage) ?? "";
  }



  setPrivateKey(String key) {
    _savePref(_privateKey, key);
  }


  String getPrivateKey() {
    return _getPref(_privateKey) ?? "";
  }


  setPublicKey(String key) {
    _savePref(_publicKey, key);
  }

  String getPublicKey() {
    return _getPref(_publicKey) ?? "";
  }

  bool isKeysSet(){
    return false;
      // GetStorage().hasData(_privateKey);
  }


}
