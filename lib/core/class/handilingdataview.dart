// ignore_for_file: use_super_parameters

import 'package:delivery_app/core/class/statusrequest.dart';
import 'package:delivery_app/core/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  

  const HandlingDataRequest({
    Key? key,
    required this.statusRequest,
    required this.widget,
     
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loding
        ? Center(
            child: Lottie.asset(ImageAssets.loading, width: 250, height: 250))
        : statusRequest == StatusRequest.offlinefaliure
            ? Center(
                child:
                    Lottie.asset(ImageAssets.offline, width: 250, height: 250))
            : widget;
  }
}
