// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_import

import 'package:delivery_app/bindings/initialbinding.dart';
import 'package:delivery_app/core/localization/translation.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/localization/changedlocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller=Get.put(LocalController());
    return GetMaterialApp(
      locale: controller.language,
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Market Haven',
      theme:controller.apptheme ,
      getPages: routes,
      initialBinding:InitialBinding() ,
    );
  }
}
