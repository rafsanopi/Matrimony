import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/messages/message_model/message_model.dart';
import 'package:matrimony/view/screens/messages/message_repo/message_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController {
  MessageRepo messageRepo = MessageRepo();

  MessageModel messageModel = MessageModel();
  bool isLoading = false;
  bool payment = false;

  List<Datum> msgList = [];

  ScrollController scrollController = ScrollController();

  int pageNum = 1;
  bool dataLoading = false;

  Future<void> addScrollListener() async {
    if (dataLoading) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      dataLoading = true;
      update();

      pageNum = pageNum + 1;
      await myMsg();

      dataLoading = false;
      update();
    }
  }

  Future<void> myMsg() async {
    isLoading = true;
    paymentInfo();
    update();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString(SharedPreferenceHelper.token) ?? "";
      if (token.isEmpty) {
        return;
      }

      ApiResponseModel apiResponseModel = await messageRepo.messageRepo();

      if (apiResponseModel.statusCode == 200) {
        debugPrint("========= MsgList  : ${apiResponseModel.responseJson}");
        messageModel = messageModelFromJson(apiResponseModel.responseJson);

        List<Datum> rawData = messageModel.data ?? [];
        msgList.addAll(rawData);
        debugPrint("========= MsgList Length : ${msgList.length}");
        update();
      } else {
        debugPrint(apiResponseModel.message);
        TostMessage.toastMessage(message: apiResponseModel.message);
      }
      isLoading = false;

      update();
    } catch (e) {
      TostMessage.toastMessage(message: e.toString());
      isLoading = false;
      update();
    }
  }

  Future<bool> paymentInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isPayment = prefs.getBool(SharedPreferenceHelper.isPayment);
    payment = isPayment!;
    update();
    return isPayment;
  }

  refreshData() {
    pageNum = 1;
    msgList = [];
    myMsg();
  }

  listenSocketNewChat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);

    debugPrint("My ID============$myID");

    SocketApi.socket.on("updated-chat::$myID", (data) {
      debugPrint("-------->  New Chat response : $data");
      Datum demodata = Datum.fromJson(data);

      for (var element in msgList) {
        if (element.chat!.id == demodata.chat!.id) {
          msgList.remove(element);
          msgList.insert(0, demodata);

          break;
        } else if (!msgList.contains(demodata)) {
          msgList.insert(0, demodata);

          break;
        }
      }
      update();
    });
  }

  socketOff() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myID = prefs.getString(SharedPreferenceHelper.userIdKey);
    SocketApi.socket.off("updated-chat::$myID");
    debugPrint("========= Dispose socket $myID");
  }

  ///====================== Read message ====================

  readMessage({required String chatID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString(SharedPreferenceHelper.userIdKey);

    var body = {"chatId": chatID, "userId": userid};
    debugPrint("$body");

    SocketApi.socket.emitWithAck(
      "message/read",
      body,
      ack: (data) {
        Datum demodata = Datum.fromJson(data);

        debugPrint("Message Read response ===>>>>>>>>>>>>>>>>>>>> : $data");

        for (var element in msgList) {
          if (element.chat!.id == demodata.chat!.id) {
            msgList.remove(element);
            msgList.insert(0, demodata);
            "${element.chat!.id}========Read True2========${demodata.chat!.id}";

            break;
          } else if (!msgList.contains(demodata)) {
            msgList.insert(0, demodata);
            debugPrint(
                "${element.chat!.id}========Read False2========${demodata.chat!.id}");
            break;
          }
        }
        update();
      },
    );
  }

  ///====================== Unread Message Count ====================
  int unreadCount = 0;
  unreadMsgCount() async {
    ApiService apiService = ApiService(sharedPreferences: Get.find());
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.unreadMsgCount}";
    String responseMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 200) {
      var response = jsonDecode(responseModel.responseJson);
      unreadCount = response["data"]["attributes"]["count"];
      debugPrint("Message Unread Count==========>>>>>>>>> $unreadCount");
      update();
    }
  }

  // ///====================== Unread Message Count Socket ====================
  unreadMsgCountSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString(SharedPreferenceHelper.userIdKey);
    SocketApi.socket.on("new-chat::$userid", (data) {
      // unreadCount = data["totalUnread"];
      listenSocketNewChat();
      debugPrint("Unread Socket ===========>>>>>>>>>$unreadCount");
      unreadMsgCount();
      update();
    });
  }

  @override
  void onInit() {
    scrollController.addListener(addScrollListener);
    listenSocketNewChat();
    unreadMsgCountSocket();
    myMsg();
    unreadMsgCount();
    super.onInit();
  }
}
