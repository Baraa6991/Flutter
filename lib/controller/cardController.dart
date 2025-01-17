// ignore_for_file: unnecessary_import, non_constant_identifier_names, file_names, avoid_renaming_method_parameters, annotate_overrides, avoid_print, prefer_const_declarations, prefer_const_constructors, unused_element, deprecated_member_use, unused_local_variable
import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class CardController extends GetxController {
  Future<void> AddToCard({
    required int quantity,
    required int storeId,
    required int productId,
    required String productName,
    required String productImage,
    required double productPrice,
    required int availableQuantity,
  });
  Confirmorder();
  DeletProduct(int cartId);
  UpDateQuantity({
    required int cartId,
    required int newQuantity,
  });
  fetchCartItems();
  fetchOldReceipts();
}

class CardControllerControllerImp extends CardController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  var errorMessage = ''.obs;
  RxDouble totalPrice = 0.0.obs;
  var priceee = ''.obs;
  var orders = <Map<String, dynamic>>[].obs;

  @override
  Future<void> AddToCard({
    required int quantity,
    required int storeId,
    required int productId,
    required String productName,
    required String productImage,
    required double productPrice,
    required int availableQuantity,
  }) async {
    isLoading.value = true;

    try {
      // التحقق من الكمية المدخلة
      if (quantity > availableQuantity) {
        Get.snackbar(
          "Error",
          "الكمية المطلوبة غير متوفرة.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return; // إيقاف العملية إذا كانت الكمية غير متوفرة
      }

      // التحقق من وجود المنتج بنفس productId و storeId
      final existingItemIndex = cartItems.indexWhere(
        (item) => item['productId'] == productId && item['storeId'] == storeId,
      );

      if (existingItemIndex != -1) {
        // إذا كان المنتج موجودًا بنفس productId و storeId
        Get.snackbar(
          "Notice",
          "The product is already in the cart.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      } else {
        // إذا لم يكن المنتج موجودًا، قم بإضافته
        final response = await Network.postData(
          url: "${Urls.auth}/cart",
          data: {
            "quantity":
                quantity.toString(), // تحويل الكمية إلى String إذا لزم الأمر
            "store_id":
                storeId.toString(), // تحويل storeId إلى String إذا لزم الأمر
            "product_id": productId
                .toString(), // تحويل productId إلى String إذا لزم الأمر
          },
        );

        if (response.statusCode == 200 && response.data['successful']) {
          // استخراج البيانات من الاستجابة
          final cartItem = response.data['data'];
          final cartId = cartItem['id'];
          final userId = cartItem['user_id'];
          final storeProductId = cartItem['store_product_id'];
          final quantityStr = cartItem['quantity']?.toString();
          var totalPriceResponse =
              cartItem['total_price']; // قيمة total_price هي double أو int

          // التأكد من أن totalPriceResponse هو double
          if (totalPriceResponse is int) {
            totalPriceResponse =
                totalPriceResponse.toDouble(); // تحويل إلى double إذا كان int
          }

          // التأكد من أن quantityStr تحتوي على قيمة صحيحة قبل تحويلها
          int quantity = 0;
          if (quantityStr != null && quantityStr.isNotEmpty) {
            quantity =
                int.tryParse(quantityStr) ?? 0; // حاول تحويل القيمة إلى int
          }

          // إضافة المنتج إلى الـ cartItems
          cartItems.add({
            "id": cartId,
            "productId": productId,
            "storeId": storeId,
            "userId": userId,
            "productName": productName,
            "productImage": productImage,
            "quantity": quantity,
            "productPrice": productPrice,
            "totalPrice": totalPriceResponse, // إضافة السعر الإجمالي
          });

          // تحديث إجمالي السعر
          totalPrice.value = totalPriceResponse; // تعيين القيمة بشكل صحيح الآن

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
            response.data['message'] ?? "Failed to add item to cart",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } on DioException catch (e) {
      String errorMessage = exceptionsHandle(error: e);
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkQuantityAvailability(
      String storeProductId, int quantity) async {
    try {
      final response = await Network.getData(
        url: "${Urls.auth}/product/$storeProductId",
      );

      if (response.statusCode == 200 && response.data['successful']) {
        final remainingStock = response.data['data']['remaining_stock'] as int;
        return quantity <= remainingStock;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "فشل في التحقق من الكمية",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  void showEditQuantityDialog(BuildContext context,
      CardControllerControllerImp controller, int cartId) {
    final TextEditingController quantityController = TextEditingController();

    Get.defaultDialog(
      title: "تعديل الكمية",
      content: Column(
        children: [
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "الكمية الجديدة",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      textConfirm: "OK",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        final newQuantity = int.tryParse(quantityController.text);

        if (newQuantity == null || newQuantity <= 0) {
          Get.snackbar(
            "خطأ",
            "يرجى إدخال كمية صالحة",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // استدعاء تابع تعديل الكمية
        await controller.UpDateQuantity(
          cartId: cartId, // تمرير معرف المنتج فقط
          newQuantity: newQuantity,
        );
      },
    );
  }

  @override
  Future<void> UpDateQuantity({
    required int cartId, // معرف السلة
    required int newQuantity, // الكمية الجديدة
  }) async {
    isLoading.value = true;

    try {
      // إرسال طلب تعديل الكمية إلى السيرفر
      final updateResponse = await Network.putData(
        url: "${Urls.auth}/cart/$cartId", // الرابط مع معرف المنتج
        data: {
          "quantity": newQuantity, // الكمية الجديدة
        },
      );

      if (updateResponse.statusCode == 200 &&
          updateResponse.data['successful']) {
        final updatedCartItem =
            updateResponse.data['data']['updated_cart_item'];

        // تحديث السلة المحلية
        int index = cartItems.indexWhere(
          (item) => item['id'] == cartId,
        );

        if (index != -1) {
          cartItems[index]['quantity'] = updatedCartItem['quantity'];
          cartItems[index]['total_price'] = updatedCartItem['total_price'];
        }

        // تحديث السعر الإجمالي
        updateTotalPrice();

        Get.snackbar(
          "تم التعديل",
          "تم تحديث الكمية بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "خطأ",
          updateResponse.data['message'] ?? "فشل في تحديث الكمية",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء تحديث الكمية: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  DeletProduct(int cartId) async {
    isLoading.value = true;

    try {
      // إرسال طلب الحذف باستخدام id الخاص بالسلة
      final response = await Network.deleteData(
        url: "${Urls.auth}/cart/$cartId", // استخدام id الخاص بالسلة
      );

      if (response.statusCode == 200 && response.data['successful']) {
        // إزالة العنصر من القائمة المحلية بناءً على id
        cartItems.removeWhere((item) => item['id'] == cartId);

        // تحديث إجمالي السعر
        updateTotalPrice();

        // إظهار رسالة نجاح
        Get.snackbar(
          "Success",
          "Product removed from the cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // إظهار رسالة خطأ في حال فشل الحذف
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to remove item from cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // معالجة الأخطاء غير المتوقعة
      Get.snackbar(
        "Error",
        "An error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateTotalPrice() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item['total_price'] ?? 0.0),
    );
  }

  Future<void> fetchCartItems() async {
    isLoading.value = true;
    var url = '${Urls.auth}/show/cart';

    try {
      final response = await Network.getData(url: url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['successful'] == true) {
          // استخراج المنتجات
          final productList = data['data'][0] as List;
          cartItems.value = productList.map((product) {
            return {
              'id': product['id'],
              'productName': product['product_name'],
              'productImage': product['product_image'],
              'quantity': product['quantity'],
              'total_price': (product['price'] is int)
                  ? (product['price'] as int).toDouble()
                  : product['price'],
            };
          }).toList();

          final total = data['data'][1]['total_price'];
          totalPrice.value = total;
        } else {
          Get.snackbar("Error", "Failed to fetch cart data");
        }
      } else {
        Get.snackbar("Error", "API Error: ${response.statusCode}");
      }
    } catch (e) {
      // في حال حدوث خطأ
      String errorMessage = exceptionsHandle(error: e as DioException);
      Get.snackbar("Error", "Failed to fetch data: $errorMessage");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> Confirmorder() async {
    isLoading.value = true;
    update();

    try {
      // إرسال طلب تأكيد الطلب
      final response = await Network.postData(
        url: "${Urls.auth}/order",
        data: {
          "cart_items": cartItems.map((item) {
            return {
              "store_product_id": item['store_product_id'],
              "quantity": item['quantity'],
            };
          }).toList(),
        },
      );

      if (response.statusCode == 200 && response.data['successful']) {
        // إظهار رسالة نجاح
        Get.snackbar(
          "Order Confirmed",
          response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // مسح السلة محليًا
        cartItems.clear();
        totalPrice.value = 0.0;
        update();
      } else {
        // إظهار رسالة خطأ في حال فشل الطلب
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to confirm order",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      // معالجة الأخطاء
      String errorMessage = exceptionsHandle(error: e);
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchOldReceipts() async {
    try {
      isLoading.value = true;
      final response = await Network.getData(url: '${Urls.auth}/orders');
      print("Response Data: ${response.data}");
      if (response.statusCode == 200 && response.data['successful']) {
        final fetchedOrders = response.data['data']['orders'] as List;
        orders.value = fetchedOrders.map((order) {
          return {
            "id": order['id'],
            "total_price": order['total_price'].toString(),
            "cart_items": List<Map<String, dynamic>>.from(order['cart_items']),
          };
        }).toList();
      } else {
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to fetch orders.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      print("Error: $error");
      Get.snackbar(
        "Error",
        "An error occurred: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
