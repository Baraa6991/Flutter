// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:delivery_app/controller/auth/logIn_controller.dart';
import 'package:delivery_app/core/class/handilingdataview.dart';
import 'package:delivery_app/core/functions/alertexitapp.dart';
import 'package:delivery_app/core/functions/validinput.dart';
import 'package:delivery_app/view/wedgets/LogIn_text_SignUp.dart';
import 'package:delivery_app/view/wedgets/logInTextSupTitle.dart';
import 'package:delivery_app/view/wedgets/logInTextTitle.dart';
import 'package:delivery_app/view/wedgets/loginButton.dart';
import 'package:delivery_app/view/wedgets/loginTextField.dart';
import 'package:delivery_app/view/wedgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/localization/changedlocal.dart';

class LogIn extends GetView<LocalController> {
  @override
  Widget build(BuildContext context) {
    Get.put(LogInControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'LogIn Button'.tr,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.grey[800]),
          ),
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LogInControllerImp>(
          builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: logInScreen(controller)),
        ),
      ),
    );
  }

  Widget logInScreen(LogInControllerImp controller) {
    return Form(
      key: controller.formstate,
      child: ListView(
        children: [
          SizedBox(height: 20),
          Logo(),
          LogInTextTitle(
            title: 'LogIn Title',
          ),
          SizedBox(height: 15),
          LogInTextSupTitle(
            fontSize: 15,
            SupTitle: 'LogIn SupTitle',
          ),
          SizedBox(height: 50),
          LogInTextField(
            isNumber: true,
            validator: (val) {
              return validInput(val!, 10, 10, "phonenumber");
            },
            hintText: "LogIn hintText 1".tr,
            labelText: "labelText".tr,
            iconData: Icons.phone_android_outlined,
            myController: controller.phone,
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: LogInButton(
              () {
                controller.LogIn();
              },
              title: "LogIn Button".tr,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LogIn end'.tr,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextSignUp(
                text: "LogIn end 1".tr,
                () {
                  controller.goToSignUp();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
