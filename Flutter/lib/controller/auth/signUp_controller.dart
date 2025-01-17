// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:delivery_app/core/class/statusrequest.dart';
import 'package:delivery_app/core/functions/checkinternet.dart';
import 'package:delivery_app/data/datasource/remot/auth/signup.dart';
import 'package:delivery_app/view/wedgets/imagepicker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
// import 'package:get/get.dart';
import '../../core/constant/route.dart';

abstract class SignUpController extends GetxController {
  SignUp();
  goToSignIN();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController locatoin;
  late TextEditingController phone;
  late bool isshowePassword = true;
  SignupData signupData = SignupData(Get.find());
  List data = [];
  StatusRequest statusRequest = StatusRequest.none;
  @override
  SignUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      if (!(await CheckInternet())) {
        statusRequest = StatusRequest.offlinefaliure;
        update();
      } else {
        statusRequest = StatusRequest.loding;
        update();
        await signUpPostApi();
      }
    } else {
      print("Form is not valid");
    }
  }

  Future signUpPostApi() async {
    var formData = FormData.fromMap({
      "first_name": firstname.text,
      "last_name": lastname.text,
      "location": locatoin.text,
      "mobile": phone.text,
      if (imagePickerController.selectedImage != null)
        'image': await MultipartFile.fromFile(
            imagePickerController.selectedImage!.path,
            filename: "image.png"),
    });
    try {
      await Network.postData(url: Urls.register, data: formData).then((value) {
        print(value.data);
        if (value.data['successful'] == true) {
          statusRequest == StatusRequest.success;
          Get.offNamed(Approute.saccessSignUp);
        }
      }).catchError((error) {
        statusRequest = StatusRequest.serverExceptoin;
        update();
        Get.defaultDialog(
          title: "Error",
          middleText: "Server Error\nPlease Try Again",
        );
      });
    } catch (error) {
      statusRequest = StatusRequest.serverfaliure;
      update();
      print(statusRequest);
      if (error is DioException) {
        Get.defaultDialog(
            title: "Error", middleText: exceptionsHandle(error: error));
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText: error.toString(),
        );
      }
    }
  }

  @override
  goToSignIN() {
    Get.offNamed(Approute.signUp);
  }

  @override
  void onInit() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    locatoin = TextEditingController();
    phone = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    locatoin.dispose();
    phone.dispose();
    super.dispose();
  }
}
