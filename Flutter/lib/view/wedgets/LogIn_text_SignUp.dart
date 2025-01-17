// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
class TextSignUp extends StatelessWidget {
  const TextSignUp(
    this.onTap, 
    {
    super.key,
    required this.text,
  });
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}
