// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, unnecessary_import

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import 'homescreencardview.dart/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final HomePageControllerImp controller = Get.put(HomePageControllerImp());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(ImageAssets.loading, width: 250, height: 250),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else {
          return Container(
            height: 450,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: controller.categories.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 7 / 8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) {
                final category = controller.categories[index];
                return CategoryItem(
                  category['id'].toString(),
                  category['name'],
                  category['image'],
                );
              },
            ),
          );
        }
      },
    );
  }
}
