// ignore_for_file: unnecessary_import

import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await AppSharedPreferences.init();
  await Network.init();
  await Get.putAsync(() => MyServices().init());
}
