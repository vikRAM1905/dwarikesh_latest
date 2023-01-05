import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static Future<bool> delete() async {
    _prefsInstance = await _instance;
    return _prefsInstance!.clear();
  }

  /* GET VALUE */

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static bool getBoolen(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance!.getInt(key) ?? defValue ?? 0;
  }

  static getDouble(String key, [double? defValue]) {
    return _prefsInstance!.getDouble(key) ?? defValue ?? 0.00;
  }

  /* SET VALUE */

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setBoolen(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    var prefs = await _instance;
    return prefs.setDouble(key, value);
  }
}
