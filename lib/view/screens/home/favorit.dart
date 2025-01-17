// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:delivery_app/controller/favoriteController.dart';
import 'package:delivery_app/view/screens/home/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/controller/productsController.dart';

class Favorit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteControllerImp favoritesController = Get.put(FavoriteControllerImp());
    final ProductsControllerImp productsControllerImp = Get.put(ProductsControllerImp());

    // جلب بيانات المفضلة عند فتح الصفحة
    favoritesController.fetchFavorites();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.grey[800],
              ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (favoritesController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.orange),
          );
        }

        if (favoritesController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              favoritesController.errorMessage.value,
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (favoritesController.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.nodata,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  'لا توجد منتجات مفضلة حالياً.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: favoritesController.favorites.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 1.4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) {
            final product = favoritesController.favorites[index];
            return GestureDetector(
              onTap: () {
                productsControllerImp.goToDiscribtion(
                  productName: product['name'],
                  productImage: product['image'],
                  categoryId: product['category_id'],
                  storeId: product['store_id'],
                  productId: product['id'],
                  storeName: '', // اسم المتجر غير متوفر في الرد الحالي
                );
              },
              child: Product(
                productName: product['name'],
                productImage: product['image'],
                categoryId: product['category_id'],
                storeId: product['store_id'],
                productId: product['id'],
                storeName: '', // اسم المتجر غير متوفر في الرد الحالي
              ),
            );
          },
        );
      }),
    );
  }
}
