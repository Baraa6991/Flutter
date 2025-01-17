// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:delivery_app/controller/onboardingcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class onBoardingButton extends GetView<OnBoardingControllerImp> {
  const onBoardingButton(
    this.onPressed, {
    super.key,
    required this.title,
    required this.color,
  });
  final String? title;
  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 300,
        height: 52,
        child: Text(
          title!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
