// ignore_for_file: prefer_const_constructors, file_names, unnecessary_import, deprecated_member_use

import 'package:delivery_app/controller/onboardingcontroller.dart';
import 'package:delivery_app/data/datasource/static/onBoarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InterFaceOnBoarding extends GetView<OnBoardingControllerImp> {
  const InterFaceOnBoarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: OnBoardingList.length,
      itemBuilder: (context, i) => Column(
        children: [
          Text(
            OnBoardingList[i].title!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            OnBoardingList[i].imageUrl!,
            width: 200,
            height: 230,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            OnBoardingList[i].body!,
            style: TextStyle(
              fontSize: 20,
              height: 2,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
