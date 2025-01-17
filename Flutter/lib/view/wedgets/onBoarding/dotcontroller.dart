// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controller/onboardingcontroller.dart';
import 'package:delivery_app/data/datasource/static/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DotController extends StatelessWidget {
  const DotController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            OnBoardingList.length,
            (index) => AnimatedContainer(
              margin: EdgeInsets.only(right: 8),
              duration: Duration(milliseconds: 100),
              width: controller.currentPage==index?20:5,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
