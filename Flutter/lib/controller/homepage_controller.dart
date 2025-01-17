// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, unnecessary_overrides, avoid_print

import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:delivery_app/core/constant/route.dart';
import 'package:delivery_app/view/screens/home/card.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/searchScreen.dart';
import 'package:delivery_app/view/screens/home/profile.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/homepage.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  goToStoresSreen(String categoryName, int categoryId);
  changePage(int currentpage);
  searchProducts(String query);
  GoToSearshScreen();
}

class HomePageControllerImp extends HomePageController {
  bool isSearch = false;
  int indexPage = 0;
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> searchedProducts = [];
  List<Widget> listpage = [
    const HomePage(),
    const Cardd(),
    const ProfileScreen(),
    const SearchScreen(),
  ];
  CeackSearch(String val) {
    if (val.isEmpty) {
      isSearch = false;
    }
    update();
  }

  OnSearchProducts() {
    isSearch = true;
    update();
  }

  @override
  goToStoresSreen(String categoryName, int categoryId) {
    Get.toNamed(
      Approute.storesscreen,
      arguments: {"categoryName": categoryName.tr, "categoryId": categoryId},
    );
  }

  Future<void> fetchCategories() async {
    try {
      dio.Response response = await Network.getData(url: Urls.home);
      if (response.statusCode == 200) {
        categories = List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioException catch (e) {
      throw Exception(exceptionsHandle(error: e));
    }
  }

  @override
  changePage(int currentpage) {
    indexPage = currentpage;
    update();
  }

  @override
  GoToSearshScreen() {
    Get.toNamed(Approute.searshscreen);
  }
  @override
  Future<void> searchProducts(String query) async {
  try {
    isSearch = true;
    update();

    final response = await Network.getData(url: "${Urls.auth}/search/$query");
    

    if (response.statusCode == 200 && response.data['successful']) {
      
      // فك القوائم الفرعية ودمجها في قائمة واحدة
      List<dynamic> rawData = response.data['data'];
      searchedProducts = rawData.expand((list) => list).cast<Map<String, dynamic>>().toList();
    } else {
      searchedProducts = [];
    }
  } catch (e) {
    searchedProducts = [];
    print("Error while searching: $e");
  } finally {
    update();
  }
}

}
