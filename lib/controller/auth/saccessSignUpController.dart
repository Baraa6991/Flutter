// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, unnecessary_overrides

import 'package:get/get.dart';
import '../../core/constant/route.dart';

abstract class SuccessSignUpController extends GetxController {
  goToLogin();
}

class SuccessSignUpControllerImp extends SuccessSignUpController {
  @override
  goToLogin() {
    Get.offNamed(Approute.login);
  }
}
