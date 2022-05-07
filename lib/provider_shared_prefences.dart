import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderSharedPrefences with ChangeNotifier {
  static late SharedPreferences _sharedPreferencesObject;

  static String get getUserName =>
      _sharedPreferencesObject.getString('userName') as String;

  static bool get isUserNameNull =>
      !_sharedPreferencesObject.containsKey('userName');

  Future<void> initializeSharedPref() async {
    _sharedPreferencesObject = await SharedPreferences.getInstance();
    notifyListeners();
  }

  static clearSharedPref() => _sharedPreferencesObject.clear();

  static setSharedPrefences(String key, String value) {
    _sharedPreferencesObject.setString(key, value);
  }
}
