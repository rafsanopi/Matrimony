import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/notification/notifiaction_model/notifiaction_model.dart';
import 'package:matrimony/view/screens/notification/notifiaction_repo/notifiaction_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  NotificationRepo notificationRepo = NotificationRepo();

  bool isLoading = false;

  List<Result> results = [];

  NotificationModel notificationModel = NotificationModel();
  ScrollController scrollController = ScrollController();

  int pageNum = 1;
  bool dataLoading = false;

  int? unReadCount = 0;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await notification();

      dataLoading = false;
      update();
    }
  }

  Future<void> notification() async {
    isLoading = true;

    update();
    ApiResponseModel responseModel =
        await notificationRepo.notificationRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      notificationModel =
          NotificationModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Result>? rawData = notificationModel.data?.attributes?.results;

      if (rawData != null && rawData.isNotEmpty) {
        results.addAll(rawData);

        unReadCount = notificationModel.data?.attributes!.unReadCount!;
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  refreshNotification() {
    pageNum = 1;
    results = [];
    update();
    notification();
  }

//==================================Socket Notification===============================

  notificationSocketResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);
    SocketApi.socket.on("new-notification::$myID", (data) {
      debugPrint(
          "Notification Socket----------------->>>>>>>>>>>>>>>>>>>>>>>$data");

      Result rawvalue = Result.fromJson(data);

      results.insert(0, rawvalue);

      unReadCount = unReadCount! + 1;

      update();
    });
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    notificationSocketResponse();
    notification();
    super.onInit();
  }
}
