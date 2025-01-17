// ignore_for_file: unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:delivery_app/core/constant/route.dart';
import 'package:delivery_app/core/localization/changedlocal.dart';
import 'package:delivery_app/view/wedgets/language/languageButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              'choose language'.tr,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          LanguageButton(
            textButton: 'Ar',
            onPressed: () {
              controller.changeLang('ar');
              Get.offNamed(Approute.onBoarding);
            },
          ),
          SizedBox(height: 20),
          LanguageButton(
            textButton: 'En',
            onPressed: () {
              controller.changeLang('en');
              Get.offNamed(Approute.onBoarding);
            },
          ),
        ],
      ),
    );
  }
}
