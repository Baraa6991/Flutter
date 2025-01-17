// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, file_names, must_be_immutable

import 'package:delivery_app/controller/productsController.dart';
import 'package:delivery_app/controller/storiescontroller.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/view/screens/home/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductsScreen extends GetView<StoriesControllerImp> {
  final String storeName = Get.arguments?['storeName'] ?? 'Default Store Name';
  final int? categoryId = Get.arguments?['categoryId'];
  final int? storeId = Get.arguments?['storeId'];
  final int? productId = Get.arguments?['productId'];

  @override
  Widget build(BuildContext context) {
    ProductsControllerImp productsControllerImp =
        Get.put(ProductsControllerImp());

    if (categoryId != null && storeId != null) {
      productsControllerImp.fetchProductsByStoreId(categoryId!, storeId!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            storeName,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (productsControllerImp.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          if (productsControllerImp.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                productsControllerImp.errorMessage.value,
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (productsControllerImp.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    ImageAssets.loading,
                    width: 200,
                    height: 200,
                    repeat: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'لا توجد منتجات متاحة حالياً.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: productsControllerImp.products.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 1.4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              final product = productsControllerImp.products[index];
              return GestureDetector(
                onTap: () {
                  productsControllerImp.goToDiscribtion(
                    productName: product['name'],
                    productImage: product['image'],
                    categoryId: categoryId as int,
                    storeId: storeId as int,
                    productId: product['productId'],
                    storeName: storeName,
                  );
                },
                child: Product(
                  productName: product['name'],
                  productImage: product['image'],
                  categoryId: categoryId as int,
                  storeId: storeId as int,
                  productId: product['id'],
                  storeName: storeName,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
