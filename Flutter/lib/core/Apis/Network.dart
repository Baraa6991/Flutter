// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'dart:io' as io; // لاستخدام IO فقط في الأنظمة الداعمة
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart'; // لتحديد المنصة
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../SharedPreferences/SharedPreferencesHelper.dart';

class Network {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 40),
      headers: {
        'Content-Type': 'application/json',
        "Accept": 'application/json',
        "Accept-Charset": "application/json",
      },
    ));

  
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        request: true,
        compact: true,
        maxWidth: 1000));

    if (!kIsWeb && (io.Platform.isAndroid || io.Platform.isIOS)) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (io.HttpClient client) {
        client.badCertificateCallback =
            (io.X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static Future<Response> getData({
    required String url,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
    };
    final response = await dio.get(url);
    return response;
  }

  static Future<Response> postData({
    required String url,  
    var data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
    };
    return await dio.put(url, data: data);
  }

 

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Authorization': "Bearer ${AppSharedPreferences.getToken}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
    };
    return await dio.delete(url, data: data);
  }
}
