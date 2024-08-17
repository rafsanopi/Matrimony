import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/send_request/send_request_controller/send_request_controller.dart';
import 'package:matrimony/view/widget/custom_loader/custom_loader.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMatchRequest {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  //Update Match Req

  // static Sentre matchReqController = Get.find<MatchReqController>();
  static SendMatchReqController sendMatchReqController =
      Get.find<SendMatchReqController>();

  static HomeController homeController = Get.find<HomeController>();

  //=============================Send Match Req========================

  static bool buttonLoading = false;

  static Future<void> matchReq({
    required String id,
  }) async {
    showPopUpLoader();

    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.sendMatchRequest}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      homeController.home();
      sendMatchReqController.refreshData();
      TostMessage.toastMessage(message: responseModel.message);
      navigator!.pop();
    } else if (responseModel.statusCode == 402) {
      navigator!.pop();

      AllPopUp.reachedLimitDiolog();
    } else {
      //TostMessage.toastMessage(message: responseModel.message);
      navigator!.pop();
    }
  }

  //=============================Check If payment is exist or not========================

  static checkPaymentAndMatchReq({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool paymentInfo = prefs.getBool(SharedPreferenceHelper.isPayment)!;

    bool freeSubscription =
        prefs.getBool(SharedPreferenceHelper.freeSubscription)!;

    if (paymentInfo || freeSubscription) {
      matchReq(
        id: id,
      );
    } else {
      AllPopUp.noPaymentFound();
    }
  }

  static showPopUpLoader() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) {
          return const SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              //child: CustomLoader(),
              content: CustomLoader(),
            ),
          );
        });
  }
}
