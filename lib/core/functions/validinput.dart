import 'package:get/get_utils/src/get_utils/get_utils.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (val.isEmpty) {
      return " can not be Empty";
    } else if (!GetUtils.isUsername(val)) {
      return "Not Valid UserName";
    }
  }

  if (type == "email") {
    if (val.isEmpty) {
      return " can not be Empty";
    } else if (!GetUtils.isEmail(val)) {
      return "Not Valid email";
    }
  }
  if (type == "phonenumber") {
    if (val.isEmpty) {
      return " can not be Empty";
    } else if (!GetUtils.isPhoneNumber(val)) {
      return "Not Valid phonenumber";
    }
  }
  if (val.isEmpty) {
    return " can not be Empty";
  }

  if (val.length < min) {
    return " can not be less than $min";
  }
  if (val.length > max) {
    return " can not be larger than $max";
  }
}
