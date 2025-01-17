// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'dart:io';
import 'package:delivery_app/core/Apis/ExceptionsHandle.dart';
import 'package:delivery_app/core/Apis/Network.dart';
import 'package:delivery_app/core/Apis/Urls.dart';
import 'package:delivery_app/core/constant/route.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

abstract class ProfilContoller extends GetxController {
  LogOut();
  ChengeLang();
  OldFatorasFunction();
  GoToFavoriteScreen();
  ProfilePhotoAndHistory();
  UpdateProfile({
    required String name,
    File? image,
    required int userId,
  });
}

class ProfilContollerImp extends ProfilContoller {
  RxString userProfileImage = ''.obs;
  RxString fullName = ''.obs;
  RxString accountCreationDate = ''.obs;
  RxInt userId = 0.obs;

  @override
  Future<void> ProfilePhotoAndHistory() async {
    try {
      final response = await Network.postData(url: Urls.getImageUrl('me'));
      if (response.statusCode == 200) {
        final data = response.data['data'];

        if (data != null) {
          userProfileImage.value = data['image'] ?? '';
          fullName.value = '${data['first_name']} ${data['last_name']}';
          accountCreationDate.value = data['created_at'] ?? '';
          userId.value = data['id'];

         
        }
      }
    } catch (e) {
      print('Error in ProfilePhotoAndHistory: $e');
    }
  }

  @override
  Future<void> LogOut() async {
    try {
      final response = await Network.postData(url: Urls.logout);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['successful'] == true) {
          Get.snackbar('Success', data['message']);
          Get.offAllNamed(Approute.login);
        } else {
          Get.snackbar('Error', 'Logout failed');
        }
      } else {
        Get.snackbar('Error', 'Failed to logout');
      }
    } on DioException catch (e) {
      final errorMessage = exceptionsHandle(error: e);
      Get.snackbar('Error', errorMessage);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }

  @override
  ChengeLang() {}

  @override
  OldFatorasFunction() {
    Get.toNamed(Approute.oldFatoras);
  }

  @override
  Future<void> UpdateProfile({
    required String name,
    File? image,
    required int userId,
  }) async {
    try {
      final nameParts = name.split(' ');
      String firstName = nameParts.isNotEmpty ? nameParts.first : '';
      String lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      dio.FormData formData = dio.FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        if (image != null)
          'image': await dio.MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await Network.postData(
        url: Urls.updateProfile(userId),
        data: formData,
      );

      if (response.statusCode == 200 && response.data['successful'] == true) {
        Get.snackbar('Profile Update', 'Profile updated successfully');

        // استدعاء تحديث الملف الشخصي
        await ProfilePhotoAndHistory();
      } else {
        Get.snackbar('Error', response.data['message'] ?? 'Update failed');
      }
    } catch (e) {
      print('Error in UpdateProfile: $e');
    }
  }
  
  @override
  GoToFavoriteScreen() {
   Get.toNamed(Approute.favorit);
  }
}
