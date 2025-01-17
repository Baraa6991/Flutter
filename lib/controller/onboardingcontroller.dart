// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/core/constant/route.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/datasource/static/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnBoardingController extends GetxController {
  next();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController {
  MyServices myServices = Get.find();
  int currentPage = 0;
  late PageController pageController;
  @override
  next() {
    currentPage++;
    if (currentPage > OnBoardingList.length - 1) {
      myServices.sharedPreferences.setString("onboarding", "1");
      Get.offAllNamed(Approute.login);
    } else {
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
    }
  }

  nextskip() {
    myServices.sharedPreferences.setString("onboardingskip", "2");
    Get.offAllNamed(Approute.login);
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
