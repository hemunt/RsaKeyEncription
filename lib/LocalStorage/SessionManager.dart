import 'AppStorage.dart';

class SessionManager {


  static const String _privateKey = "PRIVATE_KEY_2048";
  static const String _publicKey = "PUBLIC_KEY_2048";

  static setPrivateKey(String key) {
    AppStorage.store.setString(_privateKey, key);
  }


  static String getPrivateKey() {
    return AppStorage.store.getString(_privateKey) ?? "";
  }


  static setPublicKey(String key) {
    AppStorage.store.setString(_publicKey, key);
  }

  static String getPublicKey() {
    return AppStorage.store.getString(_publicKey) ?? "";
  }

  static bool isKeysSet(){
    return AppStorage.store.containsKey(_privateKey);
  }


}
