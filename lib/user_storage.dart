
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }



  static Future<bool> saveData(
      {required String key, required bool value}) async {
      return await _prefs.setBool(key, value);
  }

  

  static bool getData({required String key}) {
    return _prefs.getBool(key) ?? false;
  }
}
