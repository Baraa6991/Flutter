// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  const LogInButton( this.onPressed,{super.key,required this.title,required this.color,});
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
