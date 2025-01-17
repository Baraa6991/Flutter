import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

abstract class FavoriteController extends GetxController {
  AddToFavorite({
    required int storeId,
    required int productId,
  });
  fetchFavorites();
}

class FavoriteControllerImp extends FavoriteController {
  var favorites = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isFavorite = false.obs;

  Future<void> AddToFavorite({
    required int storeId,
    required int productId,
  }) async {
    try {
      final response = await Network.postData(
        url: "${Urls.auth}/add/favourites",
        data: {
          "store_id": storeId.toString(),
          "product_id": productId.toString(),
        },
      );

      if (response.statusCode == 201 && response.data['successful']) {
        isFavorite.value = !isFavorite.value;
        Get.snackbar(
          "Success",
          response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to add to favorites",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while adding to favorites.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
Future<void> fetchFavorites() async {
  isLoading.value = true;
  errorMessage.value = '';

  try {
    final response = await Network.getData(
      url: '${Urls.auth}/get/favourites',
    );
    if (response.data['successful'] == true) {
      favorites.value = response.data['data'];
    } else {
      errorMessage.value =
          response.data['message'] ?? 'Failed to load favorites.';
    }
  } on DioException catch (e) {
    errorMessage.value = exceptionsHandle(error: e);
  } catch (e) {
    errorMessage.value = 'An unknown error occurred.';
  } finally {
    isLoading.value = false;
  }
}
}
