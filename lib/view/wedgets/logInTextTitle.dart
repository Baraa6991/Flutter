// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInTextTitle extends StatelessWidget {
  const LogInTextTitle({
    super.key, required this.title,
  });
    final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text(
        title.tr,
        style:
            Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40),
        textAlign: TextAlign.center,
      ),
    );
  }
}
