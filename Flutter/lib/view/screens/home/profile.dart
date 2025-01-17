// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:delivery_app/controller/profilController.dart';
import 'package:delivery_app/view/wedgets/loginButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ProfilContollerImp contollerImp = Get.put(ProfilContollerImp());
    contollerImp.ProfilePhotoAndHistory();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.grey[800],
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 20),
        child: Column(
          children: [
            // عرض الصورة الشخصية مع زر الكاميرا
            Obx(() {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/image-1.jpg'),
                    foregroundImage:
                        contollerImp.userProfileImage.value.isNotEmpty
                            ? NetworkImage(contollerImp.userProfileImage.value)
                            : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.orange),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        File newImage = File(pickedFile.path);
                        await contollerImp.UpdateProfile(
                          name: contollerImp.fullName.value,
                          image: newImage,
                          userId: contollerImp.userId.value,
                        );
                        await contollerImp.ProfilePhotoAndHistory();
                      }
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 30),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contollerImp.fullName.value.isNotEmpty
                        ? contollerImp.fullName.value
                        : 'Name',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      TextEditingController nameController =
                          TextEditingController(
                              text: contollerImp.fullName.value);
                      Get.defaultDialog(
                        title: "Change Name",
                        content: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "New Name",
                          ),
                        ),
                        textConfirm: "Update",
                        textCancel: "Cancel",
                        onConfirm: () async {
                          Get.back();
                          await contollerImp.UpdateProfile(
                            name: nameController.text,
                            userId: contollerImp.userId.value,
                          );
                          await contollerImp.ProfilePhotoAndHistory();
                        },
                      );
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 20),

            // عرض تاريخ إنشاء الحساب
            Obx(() {
              return Text(
                contollerImp.accountCreationDate.value.isNotEmpty
                    ? 'Account created on: ${contollerImp.accountCreationDate.value}'
                    : 'History of creating account',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 100,
                  child: LogInButton(
                    () {
                      Get.defaultDialog(
                        title: "Confirm Logout",
                        middleText: "Are you sure you want to logout?",
                        textCancel: "Cancel",
                        textConfirm: "OK",
                        confirmTextColor: Colors.blue,
                        onConfirm: () {
                          Get.back();
                          contollerImp.LogOut();
                        },
                        onCancel: () {
                          Get.back();
                        },
                      );
                    },
                    title: "LogOut",
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 150,
                  height: 100,
                  child: LogInButton(
                    () {},
                    title: "Chenge Language",
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 100,
                  child: LogInButton(
                    () {
                      contollerImp.OldFatorasFunction();
                    },
                    title: "Old Fatora",
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 150,
                  height: 100,
                  child: LogInButton(
                    () {
                      contollerImp.GoToFavoriteScreen();
                    },
                    title: "Favorite",
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
