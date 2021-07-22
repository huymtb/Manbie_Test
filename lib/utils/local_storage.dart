import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String SAVE_DATA = 'saveDataKey';

  static Future<void> setString(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key) ?? '';
    return data;
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getInt(key) ?? 0;
    return data;
  }

  static Future<void> setInt(String key, int data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }

  static Future<void> setBool(String key, {bool status = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, status);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getBool(key) ?? false;
    return data;
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
