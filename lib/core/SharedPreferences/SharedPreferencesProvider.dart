// ignore_for_file: file_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static SharedPreferences? sharedPreferences;

  static SharedPreferencesProvider? sharedPreferencesProvider;
  static Future<SharedPreferencesProvider> getInstance() async {
    if (sharedPreferencesProvider == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferencesProvider = SharedPreferencesProvider();
    }
    return sharedPreferencesProvider!;
  }

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  read(String key) {
    return contains(key) ? json.decode(sharedPreferences?.getString(key) ??'') : null;
  }

  save(String key, value) {
    sharedPreferences!.setString(key, json.encode(value));
  }

  contains(String key) {
    return sharedPreferences!.containsKey(key);
  }

  remove(String key) {
    sharedPreferences!.remove(key);
  }

  clear() {
    sharedPreferences!.clear();
  }
}
