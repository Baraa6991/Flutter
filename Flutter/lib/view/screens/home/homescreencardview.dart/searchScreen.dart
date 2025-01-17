// ignore_for_file: deprecated_member_use, prefer_const_constructors, file_names

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:delivery_app/core/constant/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageControllerImp controller = Get.find<HomePageControllerImp>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "Search Screen",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (value) {
                controller.searchProducts(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter product name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // عرض النتائج
          Expanded(
            child: GetBuilder<HomePageControllerImp>(
              builder: (controller) {
                if (controller.searchedProducts.isEmpty &&
                    controller.isSearch) {
                  return Center(child: Text("No matching products found."));
                }

                return ListView.builder(
                  itemCount: controller.searchedProducts.length,
                  itemBuilder: (ctx, index) {
                    final product = controller.searchedProducts[index];

                    // تحقق من وجود الحقول الأساسية
                    final productName =
                        product['product_name'] ?? 'Unknown Product';
                    final storeName = product['store_name'] ?? 'Unknown Store';
                    final imageUrl = product['image'] ?? '';
                    final categoryId = product['category']['category_id'] ?? 1;
                    final storeId = product['store_id'] ?? 1;
                    final productId = product['product_id'] ?? 1;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () {
                          if (categoryId != null &&
                              storeId != null &&
                              productId != null) {
                            Network.getData(
                              url: Urls.getDicikrebtionByProducts(
                                categoryId,
                                storeId,
                                productId,
                              ),
                            );
                            Get.toNamed(Approute.discribtion, arguments: {
                              "categoryId": categoryId,
                              "storeId": storeId,
                              "productId": productId,
                            });
                          } else {
                            Get.snackbar(
                              "Error",
                              "Invalid product data.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              color: Colors.orange,
                            ),
                            if (imageUrl.isNotEmpty)
                              Positioned(
                                left: 2,
                                child: Image.network(
                                  imageUrl,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Positioned(
                              right: 130,
                              top: 15,
                              child: Text(
                                productName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            Positioned(
                              left: 220,
                              top: 60,
                              child: Text(
                                storeName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
