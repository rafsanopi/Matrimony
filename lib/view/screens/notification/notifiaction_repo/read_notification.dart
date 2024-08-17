import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';

class ReadNotificationRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  ///==========================Read All Notification Repo=======================

  static Future<void> readAllNotificationRepo() async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.readAllNotification}";
    String responseMethod = ApiResponseMethod.postMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    debugPrint(
        "Read Notification=================>>>>>>>>>>>>>>>>${responseModel.message}");
  }

  ///==========================Read All Notification Repo=======================

  static Future<void> singleReadNotification({required String userID}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.singleReadNotification}$userID";
    String responseMethod = ApiResponseMethod.patchMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    debugPrint(
        "Single Read Notification=================>>>>>>>>>>>>>>>>${responseModel.message}");
  }
}
