// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:delivery_app/core/constant/route.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  int? get priority => 1;
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString('onboarding') == '1') {
      return RouteSettings(name: Approute.login);
    } else if (myServices.sharedPreferences.getString('onboardingskip') ==
        '2') {
      return RouteSettings(name: Approute.login);
    }
  }
}
