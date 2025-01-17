// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_strings.dart';
import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static SharedPreferencesProvider? sharedPreferencesProvider;
  static late SharedPreferences preferences;
  static init() async {
    sharedPreferencesProvider = await SharedPreferencesProvider.getInstance();
    preferences = await SharedPreferences.getInstance();
  }

  //token
  static String get getToken =>
      sharedPreferencesProvider!.read(AppStrings.token) ?? '';
  static saveToken(String value) =>
      sharedPreferencesProvider!.save(AppStrings.token, value);
  static bool get hasToken =>
      sharedPreferencesProvider!.contains(AppStrings.token);
  static removeToken() => sharedPreferencesProvider!.remove(AppStrings.token);

  //lang
  static String get getArLang =>
      sharedPreferencesProvider!.read(AppStrings.language) ?? "en";
  static saveArLang(String value) =>
      sharedPreferencesProvider!.save(AppStrings.language, value);
  static bool get hasArLang =>
      sharedPreferencesProvider!.contains(AppStrings.language);
  static removeArLang() =>
      sharedPreferencesProvider!.remove(AppStrings.language);
}
