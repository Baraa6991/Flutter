// ignore_for_file: non_constant_identifier_names, file_names

import 'package:delivery_app/core/constant/image.dart';
import 'package:delivery_app/data/model/onBoardingModel.dart';
import 'package:get/get.dart';

List<onBoardingModel> OnBoardingList = [
  onBoardingModel(
    title: 'OnBoarding Title page 1'.tr,
    imageUrl: ImageAssets.onboardingOne,
    body: 'OnBoarding SubTitle page 1'.tr,
  ),
  onBoardingModel(
    title: 'OnBoarding Title page 2'.tr,
    imageUrl: ImageAssets.onboardingTow,
    body: 'OnBoarding SubTitle page 2'.tr,
  ),
  onBoardingModel(
    title: 'OnBoarding Title page 3'.tr,
    imageUrl: ImageAssets.onboardingThree,
    body: 'OnBoarding SubTitle page 3'.tr,
  ),
  onBoardingModel(
    title: 'OnBoarding Title page 4'.tr,
    imageUrl: ImageAssets.onboardingFour,
    body: 'OnBoarding SubTitle page 4'.tr,
  ),
];
