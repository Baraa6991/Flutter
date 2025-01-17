// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use, unnecessary_import

import 'package:delivery_app/view/wedgets/imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LogInTextField extends StatelessWidget {
  const LogInTextField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.iconData,
      this.myController,
      this.validator,
      required this.isNumber,
      this.obscureText,
      this.onTapIcon,
      this.isImagePicker = false});
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextEditingController? myController;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final bool isImagePicker;

  @override
  Widget build(BuildContext context) {
    if (isImagePicker) {
      return GetBuilder<ImagePickerController>(
        init: ImagePickerController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(iconData, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        controller.selectedImage == null
                            ? hintText
                            : "SignUp image".tr,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.file(
                    controller.selectedImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        obscureText: obscureText == null || obscureText == false ? false : true,
        keyboardType: isNumber
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.emailAddress,
        validator: validator,
        controller: myController,
        decoration: InputDecoration(
          helperStyle: TextStyle(fontSize: 9),
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 40,
          ),
          labelText: labelText,
          suffixStyle: Theme.of(context).textTheme.bodyLarge,
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(iconData),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              40,
            ),
          ),
        ),
      ),
    );
  }
}
