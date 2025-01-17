// ignore_for_file: prefer_const_constructors, unnecessary_import, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key, required this.textButton, this.onPressed,
  });
final String textButton;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed:onPressed,
        child: Text(
          textButton,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}