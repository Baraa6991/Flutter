// ignore_for_file: sort_child_properties_last, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, must_be_immutable

import 'package:delivery_app/controller/storiescontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoriesCridViewBady extends StatelessWidget {
  final String storeName;
  final String storeImage;
  final int categoryId;
  final int storeId;
  const StoriesCridViewBady({
    super.key,
    required this.storeName,
    required this.storeImage,
    required this.categoryId,
    required this.storeId,
  });
  @override
  Widget build(BuildContext context) {
    StoriesControllerImp storiesControllerImp = Get.put(StoriesControllerImp());
    return Container(
      child: Card(
        child: InkWell(
          onTap: () {
            storiesControllerImp.goToproducts(storeName,storeId,categoryId);
          },
          splashColor: Colors.orange,
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  storeImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  storeName,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
