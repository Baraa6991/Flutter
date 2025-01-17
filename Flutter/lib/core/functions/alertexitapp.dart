// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "baraa",
      middleText: "are you need exit in app",
      actions: [
        ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: Text('yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        )
      ]);
  return Future.value(true);
}
