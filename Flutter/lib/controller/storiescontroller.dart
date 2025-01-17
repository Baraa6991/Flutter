// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, unnecessary_overrides

import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:delivery_app/core/constant/route.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

abstract class StoriesController extends GetxController {
  goToproducts(String storeName, int storeId, int categoryId);
}

class StoriesControllerImp extends StoriesController {
  @override
  goToproducts(String storeName, int storeId, int categoryId) {
    Get.toNamed(
      Approute.products,
      arguments: {
        'storeName': storeName,
        'categoryId': categoryId,
        'storeId': storeId,
      },
    );
  }

  var stories = <Map<String, dynamic>>[].obs;

  Future<void> fetchStoresByCategoryId(int categoryId) async {
    try {
      dio.Response response =
          await Network.getData(url: Urls.getStoresByCategory(categoryId));
      if (response.statusCode == 200) {
        var storesData = response.data['data']['stores'];
        stories.value = List<Map<String, dynamic>>.from(storesData);
      } else {
        throw Exception('فشل تحميل المتاجر');
      }
    } on DioException catch (e) {
      throw Exception(exceptionsHandle(error: e));
    }
  }
}
