// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:delivery_app/core/class/statusrequest.dart';
import 'package:delivery_app/core/functions/checkinternet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> PostData(
      {required String linkurl,
      @required dynamic data,
      @required String? token}) async {
    Map<String, String> header = {};
    if (token != null) {
      header.addAll({
        
      });
    }
    try {
      if (await CheckInternet()) {
        var response =
            await http.post(Uri.parse(linkurl), body: data, headers: header);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfaliure);
        }
      } else {
        return const Left(StatusRequest.offlinefaliure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExceptoin);
    }
  }
}
