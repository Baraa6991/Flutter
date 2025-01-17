// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:delivery_app/controller/productsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product extends StatelessWidget {
  final String productName;
  final String productImage;
  final int categoryId;
  final int storeId;
  final int productId;
  final String storeName;

  const Product({
    required this.productName,
    required this.productImage,
    required this.categoryId,
    required this.storeId,
    required this.productId,
    required this.storeName,
  });
  @override
  Widget build(BuildContext context) {
    ProductsControllerImp productsControllerImp =
        Get.put(ProductsControllerImp());
    return InkWell(
      onTap: () {
        productsControllerImp.goToDiscribtion(
          productName: productName,
          productImage: productImage,
          categoryId: categoryId,
          storeId: storeId,
          productId: productId,
          storeName: storeName,
        );
      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.grey[300],
              height: 200,
            ),
            Image.network(
              productImage,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 190,
              child: Container(
                alignment: Alignment.center,
                width: 380,
                height: 54,
                color: Colors.grey[100],
                child: Text(
                  productName,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
