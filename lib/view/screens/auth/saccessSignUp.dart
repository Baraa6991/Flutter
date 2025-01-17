// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:delivery_app/controller/auth/saccessSignUpController.dart';
import 'package:delivery_app/view/wedgets/logInTextSupTitle.dart';
import 'package:delivery_app/view/wedgets/loginButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SaccessSignUp extends StatelessWidget {
  const SaccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignUpControllerImp controller =
        Get.put(SuccessSignUpControllerImp());
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'SaccessSignUp'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: Colors.grey[800]),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 100),
          Icon(
            size: 200,
            color: Colors.orange,
            Icons.check_circle_outline,
          ),
          SizedBox(height: 40),
          LogInTextSupTitle(
            SupTitle: 'SaccessSignUp1',
            fontSize: 25,
          ),
          SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: LogInButton(
              () {
                controller.goToLogin();
              },
              title: "successsignup".tr,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
