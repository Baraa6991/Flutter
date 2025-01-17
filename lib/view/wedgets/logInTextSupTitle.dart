// ignore_for_file: deprecated_member_use, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInTextSupTitle extends StatelessWidget {
  const LogInTextSupTitle({
    super.key,
    required this.SupTitle, required this.fontSize, 
  });
  final String SupTitle;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        SupTitle.tr,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              height: 2,
              fontSize: fontSize,
              color: Colors.grey,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
