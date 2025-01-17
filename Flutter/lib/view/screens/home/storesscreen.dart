// ignore_for_file: deprecated_member_use, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, non_constant_identifier_names

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:delivery_app/controller/storiescontroller.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/storiescridviewbady.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StoresScreen extends GetView<HomePageControllerImp> {
  final String categoryName = Get.arguments?['categoryName'] ?? 'Default Name';
  final int categoryId = Get.arguments?['categoryId'] ?? 0;

  StoresScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StoriesControllerImp controllerImp = Get.put(StoriesControllerImp());
    controllerImp.fetchStoresByCategoryId(categoryId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            categoryName,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controllerImp.stories.isEmpty) {
            return Center(
              child: Lottie.asset(ImageAssets.loading,
                  width: 250, height: 250, repeat: true),
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: controllerImp.stories.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 7 / 8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) {
                final story = controllerImp.stories[index];
                if (story.containsKey('id') &&
                    story.containsKey('name') &&
                    story.containsKey('image')) {
                  return StoriesCridViewBady(
                    storeName: story['name'],
                    storeImage: story['image'],
                    storeId: story['id'],
                    categoryId: categoryId,
                  );
                } else {
                  return Center(
                    child: Text('بيانات المتجر غير صالحة'),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
