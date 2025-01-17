// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unnecessary_import

import 'package:delivery_app/controller/onboardingcontroller.dart';
import 'package:delivery_app/view/wedgets/onBoarding/dotcontroller.dart';
import 'package:delivery_app/view/wedgets/onBoarding/interFaceOnBoarding.dart';
import 'package:delivery_app/view/wedgets/onBoarding/onBoardingButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoarding extends GetView<OnBoardingControllerImp> {
  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: InterFaceOnBoarding(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotController(),
                  SizedBox(height: 40),
                  onBoardingButton(
                      title: 'OnBoarding Button 1'.tr, color: Colors.blue, () {
                    controller.next();
                  }),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: onBoardingButton(
                        title: 'OnBoarding Button 2'.tr,
                        color: Colors.grey, () {
                      controller.nextskip();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
