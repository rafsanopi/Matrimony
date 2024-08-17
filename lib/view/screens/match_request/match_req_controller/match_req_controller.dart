import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/match_request/match_req_model/match_req_model.dart';
import 'package:matrimony/view/screens/match_request/match_req_repo/match_req_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchReqController extends GetxController with GetxServiceMixin {
  MatchReqRepo matchReqRepo = MatchReqRepo();

  MatchReqModel matchReqModel = MatchReqModel();
  bool isLoading = false;
  bool dataLoading = false;

  List<Datum> matchReqList = [];

  ScrollController scrollController = ScrollController();

  int pageNum = 1;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await matchReq();

      dataLoading = false;
      update();
    }
  }

  Future<void> matchReq() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await matchReqRepo.matchReqRepo(pageNum: pageNum.toString());

    if (responseModel.statusCode == 200) {
      matchReqList.clear();
      matchReqModel =
          MatchReqModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Datum>? rawData = matchReqModel.data!.attributes!.data;

      if (rawData != null) {
        //  results.addAll(rawData);

        matchReqList.addAll(rawData);
      }
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }

//============================Match Req Socket===========================

  matchReqSocketResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);
    SocketApi.socket.on("matchRequest::$myID", (data) {
      debugPrint("MatchRequest Socket==============>>>>>>>>>>>>>>$data");

      matchReqModel = MatchReqModel.fromJson(data);
      List<Datum>? rawData = matchReqModel.data!.attributes!.data;
      if (rawData != null) {
        matchReqList.addAll(rawData);
      }

      update();
    });
  }

  @override
  void onInit() {
    matchReqSocketResponse();
    matchReq();
    scrollController.addListener(addScrollListener);
    super.onInit();
  }
}
