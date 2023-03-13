import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const _STORAGE_KEY = 'viss_pass#key';
  static late SharedPreferences store;

  static Future<void> init() async {
    store = await SharedPreferences.getInstance();
  }
}
