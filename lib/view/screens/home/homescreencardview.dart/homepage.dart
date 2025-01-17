// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, unnecessary_import, sized_box_for_whitespace

import 'package:delivery_app/controller/homepage_controller.dart';
import 'package:delivery_app/view/screens/home/categories_screen.dart';
import 'package:delivery_app/view/wedgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
        builder: ((controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Home Page",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                ),
                centerTitle: true,
              ),
              body: ListView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(height: 200,width: 400,child: Logo()),
                        CategoriesScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
