// ignore_for_file: deprecated_member_use, prefer_const_constructors, must_be_immutable, file_names

import 'package:delivery_app/controller/cardController.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/view/screens/home/oldFatorasBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OldFatoras extends StatelessWidget {
  const OldFatoras({super.key});

      
     

  @override
  Widget build(BuildContext context) {
     final CardControllerControllerImp controllerImp =
      Get.put(CardControllerControllerImp());
      controllerImp.fetchOldReceipts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Old Fatoras',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controllerImp.isLoading.value) {
          return Center(
              child:
                  Lottie.asset(ImageAssets.loading, width: 250, height: 250));
        }

        if (controllerImp.orders.isEmpty) {
          return Center(child: Text('No orders found.'));
        }

        return ListView.builder(
          itemCount: controllerImp.orders.length,
          itemBuilder: (context, index) {
            final order = controllerImp.orders[index];
            print("Displaying Order: $order");
            return OldFatorasBody(
              orderId: order['id'],
              totalPrice: order['total_price'],
              cartItems: order['cart_items'],
            );
          },
        );
      }),
    );
  }
}
