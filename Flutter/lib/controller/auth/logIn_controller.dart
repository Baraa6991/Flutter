// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'package:delivery_app/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:delivery_app/core/class/statusrequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../core/Apis/ExceptionsHandle.dart';
import '../../core/Apis/Network.dart';
import '../../core/Apis/Urls.dart';
import '../../core/constant/route.dart';
import '../../core/functions/checkinternet.dart';

abstract class LogInController extends GetxController {
  LogIn();
  goToSignUp();
}

class LogInControllerImp extends LogInController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController phone;
  StatusRequest statusRequest = StatusRequest.none;
  late bool isshowePassword = true;
  isShowe() {
    isshowePassword = isshowePassword == true ? false : true;
    update();
  }

  @override
  LogIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      bool isConnect = await CheckInternet();
      if ((!isConnect)) {
        statusRequest = StatusRequest.offlinefaliure;
        update();
      } else {
        print("object");
        statusRequest = StatusRequest.loding;
        update();
        logInPostApi();
      }
    } else {
      print("Form is not valid");
    }
  }

  void logInPostApi() async {
    try {
      await Network.postData(url: Urls.login, data: {
        "mobile": phone.text,
      }).then((value) {
        print(value.data);
        if (value.data['successful'] == true) {
          statusRequest == StatusRequest.success;
          AppSharedPreferences.saveToken(value.data['data']);
          Get.offNamed(Approute.home);
        }
      }).catchError((error) {
        statusRequest = StatusRequest.serverExceptoin;
        update();
        Get.defaultDialog(
          title: "Error",
          middleText: "Server Error\nPlease Try Again",
        );
      });
    } catch (error) {
      statusRequest = StatusRequest.serverfaliure;
      update();
      if (error is DioException) {
        Get.defaultDialog(
            title: "Error", middleText: exceptionsHandle(error: error));
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText: error.toString(),
        );
      }
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(Approute.signUp);
  }

  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    print("dispose");
    super.dispose();
  }
}
