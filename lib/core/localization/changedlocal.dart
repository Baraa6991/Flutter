// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, unnecessary_import

import 'package:delivery_app/core/constant/AppTheme.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocalController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  ThemeData apptheme = themeArabic;
  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString('lang', langcode);
    apptheme = language == 'ar' ? themeArabic : themeEnglesh;
    Get.changeTheme(apptheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString('lang');
    if (sharedPrefLang == 'ar') {
      language = Locale('ar');
      apptheme=themeArabic;
    } else if (sharedPrefLang == 'en') {
      language = Locale('en');
      apptheme=themeEnglesh;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      apptheme=themeEnglesh;
    }
    super.onInit();
  }
}
