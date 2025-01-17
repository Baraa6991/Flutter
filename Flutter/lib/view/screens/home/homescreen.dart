// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:delivery_app/view/screens/home/homescreencardview.dart/iconnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreec extends StatelessWidget {
  const HomeScreec({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());
    return GetBuilder<HomePageControllerImp>(
      builder: ((controller) => Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Colors.orange,
              child: Row(
                children: [
                  IconNavBar(
                    onPressed: () {
                      controller.changePage(0);
                    },
                    text: "Home",
                    iconData: Icons.home_outlined,
                    activeButton: controller.indexPage == 0 ? true : false,
                  ),
                  IconNavBar(
                    onPressed: () {
                      controller.changePage(1);
                    },
                    text: "Card",
                    iconData: Icons.shopping_basket_outlined,
                    activeButton: controller.indexPage == 1 ? true : false,
                  ),
                  IconNavBar(
                    onPressed: () {
                      controller.changePage(2);
                    },
                    text: "Profile",
                    iconData: Icons.person_2_outlined,
                    activeButton: controller.indexPage == 2 ? true : false,
                  ),
                  IconNavBar(
                    onPressed: () {
                      controller.changePage(3);
                    },
                    text: "Searsh",
                    iconData: Icons.search_outlined,
                    activeButton: controller.indexPage == 3 ? true : false,
                  ),
                ],
              ),
            ),
            body: controller.listpage.elementAt(controller.indexPage),
          )),
    );
  }
}
