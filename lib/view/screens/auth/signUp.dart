// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, avoid_unnecessary_containers

import 'package:delivery_app/core/class/handilingdataview.dart';
import 'package:delivery_app/core/functions/alertexitapp.dart';
import 'package:delivery_app/core/functions/validinput.dart';
import 'package:delivery_app/view/wedgets/imagepicker.dart';
import 'package:delivery_app/view/wedgets/logInTextSupTitle.dart';
import 'package:delivery_app/view/wedgets/logInTextTitle.dart';
import 'package:delivery_app/view/wedgets/loginButton.dart';
import 'package:delivery_app/view/wedgets/loginTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/signUp_controller.dart';
import '../../../core/localization/changedlocal.dart';

class SignUp extends GetView<LocalController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'LogIn end 1'.tr,
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
        child: GetBuilder<SignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
             
              statusRequest: controller.statusRequest,
              widget: signUpScreen(controller)),
        ),
      ),
    );
  }

  Widget signUpScreen(SignUpControllerImp controller) {
    return Form(
      key: controller.formstate,
      child: ListView(
        children: [
          SizedBox(height: 20),
          LogInTextTitle(
            title: 'LogIn Title',
          ),
          SizedBox(height: 20),
          LogInTextSupTitle(
            fontSize: 15,
            SupTitle: 'SignUp MainText',
          ),
          SizedBox(height: 60),
          LogInTextField(
            isNumber: false,
            validator: (val) {
              return validInput(val!, 2, 15, "username");
            },
            hintText: "SignUp textUserName".tr,
            labelText: "SignUp labelText 1".tr,
            iconData: Icons.person_3_outlined,
            myController: controller.firstname,
          ),
          SizedBox(height: 25),
          LogInTextField(
            isNumber: false,
            validator: (val) {
              return validInput(val!, 5, 15, "username");
            },
            hintText: "SignUp textUserName1".tr,
            labelText: "SignUp labelText 8".tr,
            iconData: Icons.person_3_outlined,
            myController: controller.lastname,
          ),
          GetBuilder<ImagePickerController>(
              init: ImagePickerController(),
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: MaterialButton(
                        height: 45,
                        onPressed: () {
                          controller.pickImage();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text("SignUp image".tr,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    if (controller.selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 35),
                        child: Image.file(
                          controller.selectedImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                );
              }),
          LogInTextField(
            isNumber: false,
            validator: (val) {
              return validInput(val!, 5, 200, "username");
            },
            hintText: "SignUp Locatoin".tr,
            labelText: "SignUp labelText 15".tr,
            iconData: Icons.location_on_outlined,
            myController: controller.locatoin,
          ),
          SizedBox(height: 25),
          LogInTextField(
            isNumber: true,
            validator: (val) {
              return validInput(val!, 10, 10, "phonenumber");
            },
            hintText: "SignUp phoneNumber".tr,
            labelText: "SignUp labelText 3".tr,
            iconData: Icons.phone_outlined,
            myController: controller.phone,
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: LogInButton(
              () {
                controller.SignUp();
              },
              title: "LogIn end 1".tr,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
