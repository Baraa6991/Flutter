// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:delivery_app/controller/cardController.dart';
import 'package:delivery_app/controller/discribtionController.dart';
import 'package:delivery_app/controller/favoriteController.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/view/wedgets/floatingActionButtonPositioned.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Discribtion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String storeName = arguments?['storeName'] ?? 'Default Store';
    final String productName = arguments?['productName'] ?? 'Default Product';
    final String productImage = arguments?['productImage'] ?? 'assets/logo.jpg';
    final int productId = arguments?['productId'] ?? 0;
    final int categoryId = arguments?['categoryId'] ?? 1;
    final int storeId = arguments?['storeId'] ?? 3;

    DiscribtionControllerImp controllerImp =
        Get.put(DiscribtionControllerImp());

    controllerImp.fetchProductDetails(categoryId, storeId, productId);
    TextEditingController quantityController = TextEditingController();

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Obx(() {
            FavoriteControllerImp favoriteController =
                Get.put(FavoriteControllerImp());
            return FloatingActionButtonPositioned(
              bottom: 16,
              right: 16,
              color: Colors.orange,
              iconData: favoriteController.isFavorite.value
                  ? Icons.star
                  : Icons.star_border_outlined,
              onPressed: () async {
                await favoriteController.AddToFavorite(
                  storeId: storeId,
                  productId: productId,
                );
              },
            );
          }),
          FloatingActionButtonPositioned(
            bottom: 16,
            right: 90,
            color: Colors.blue,
            iconData: Icons.shopping_basket_outlined,
            onPressed: () {
              final quantity = int.tryParse(quantityController.text) ?? 1;

              final cardController = Get.put(CardControllerControllerImp());

              final availableQuantity = controllerImp.availableQuantity.value;

              cardController.AddToCard(
                quantity: quantity,
                storeId: storeId,
                productId: productId,
                productName: productName,
                productImage: productImage,
                productPrice:
                    double.tryParse(controllerImp.productPrice.value) ?? 0.0,
                availableQuantity: availableQuantity,
              );
            },
          ),
        ],
      ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              productImage,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              productName,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Discribtion",
              style: TextStyle(fontSize: 40, color: Colors.orange),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controllerImp.isLoading.value) {
                return Center(
                    child: Lottie.asset(ImageAssets.loading,
                        width: 250, height: 250));
              }
              if (controllerImp.errorMessage.isNotEmpty) {
                return Text(controllerImp.errorMessage.value);
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      controllerImp.productDescription.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Prise: \$${controllerImp.productPrice.value}",
                      style: TextStyle(fontSize: 30, color: Colors.green),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 200, left: 10),
              child: TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperStyle: TextStyle(fontSize: 9),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 40,
                  ),
                  labelText: "quantity",
                  suffixStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
