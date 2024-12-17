import 'dart:convert';
import 'package:azkar/features/Auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String _usersKey = 'users';
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser(UserModel user) async {
    List<String> users = _prefs.getStringList(_usersKey) ?? [];
    users.add(jsonEncode(user.toMap()));
    await _prefs.setStringList(_usersKey, users);
  }

  static Future<List<UserModel>> getUsers() async {
    List<String> users = _prefs.getStringList(_usersKey) ?? [];
    return users.map((user) => UserModel.fromMap(jsonDecode(user))).toList();
  }

  static Future<bool> saveData(
      {required String key, required bool value}) async {
      return await _prefs.setBool(key, value);
  }

  

  static bool getData({required String key}) {
    return _prefs.getBool(key) ?? false;
  }

  static Future<bool> deleteData({required String key}) async{
    return await _prefs.remove(key);
  }
}
