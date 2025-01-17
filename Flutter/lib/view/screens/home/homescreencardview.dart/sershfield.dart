// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SershField extends StatelessWidget {
  const SershField({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controllerImp=Get.put(HomePageControllerImp());
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {controllerImp.GoToSearshScreen();},
            icon: Icon(Icons.search),
          ),
          hintText: "Find Product",
          hintStyle: const TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200]),
    );
  }
}
