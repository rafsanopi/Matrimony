import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/not_interested_list/model/not_interested_model.dart';
import 'package:matrimony/view/screens/not_interested_list/repo/not_interested_repo.dart';

class NotInterestedController extends GetxController with GetxServiceMixin {
  NotInterestedListRepo notInterestedListRepo = NotInterestedListRepo();

  NotInterestedListModel notInterestedModel = NotInterestedListModel();
  bool isLoading = false;

  List<Datum> attributes = [];

  ScrollController scrollController = ScrollController();
  bool dataLoading = false;

  int pageNum = 1;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await notInterestedProfiles();

      dataLoading = false;
      update();
    }
  }

  Future<void> notInterestedProfiles() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await notInterestedListRepo
        .notInterestedRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      notInterestedModel = NotInterestedListModel.fromJson(
          jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = notInterestedModel.data?.attributes!.data;

      if (rawData != null) {
        //  results.addAll(rawData);

        attributes.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

  refreshnotInterestedList() {
    attributes = [];
    pageNum = 1;
    update();

    notInterestedProfiles();
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    notInterestedProfiles();
    super.onInit();
  }
}
