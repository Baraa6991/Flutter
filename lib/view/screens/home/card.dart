// ignore_for_file: prefer_const_constructors, unnecessary_import, sized_box_for_whitespace, deprecated_member_use, avoid_unnecessary_containers

import 'package:delivery_app/controller/cardController.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Cardd extends StatelessWidget {
  const Cardd({super.key});

  @override
  Widget build(BuildContext context) {
    final CardControllerControllerImp controllerImp =
        Get.put(CardControllerControllerImp());

    controllerImp.fetchCartItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Card',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 500,
                child: Obx(() {
                  if (controllerImp.isLoading.value) {
                    return Center(
                      child: Lottie.asset(ImageAssets.loading,
                          width: 250, height: 250),
                    );
                  }
                  if (controllerImp.cartItems.isEmpty) {
                    return Center(
                      child: Text(
                        "No items in the cart",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controllerImp.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controllerImp.cartItems[index];
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                color: Colors.orange[300],
                              ),
                              Positioned(
                                left: 2,
                                child: Image.network(
                                  item['productImage'],
                                  height: 120,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/default_image.jpg',
                                      height: 120,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                left: 180,
                                top: 15,
                                child: Text(
                                  item['productName'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              Positioned(
                                left: 180,
                                top: 60,
                                child: Text(
                                  "\$${item['total_price']}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              Positioned(
                                right: 60,
                                top: 15,
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    controllerImp.showEditQuantityDialog(
                                        context, controllerImp, item['id']);
                                  },
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 15,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    // تأكيد الحذف قبل العملية
                                    final confirm =
                                        await Get.defaultDialog<bool>(
                                      title: "تأكيد الحذف",
                                      middleText: "هل تريد حذف هذا المنتج؟",
                                      textConfirm: "نعم",
                                      textCancel: "إلغاء",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () => Get.back(result: true),
                                      onCancel: () => Get.back(result: false),
                                    );

                                    if (confirm == true) {
                                      await controllerImp.DeletProduct(
                                          item['id']); 
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
                    Obx(() {
                      return Text(
                        "\$${controllerImp.totalPrice.value.toStringAsFixed(2)}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 20),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                // إظهار حالة التحميل أثناء تأكيد الطلب
                return controllerImp.isLoading.value
                    ? Center(
                        child: Lottie.asset(ImageAssets.loading,
                            width: 250, height: 250))
                    : Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            controllerImp.Confirmorder();
                          },
                          child: Text(
                            "Save",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 30),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
