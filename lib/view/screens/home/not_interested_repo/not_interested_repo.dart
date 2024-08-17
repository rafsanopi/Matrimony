import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/not_interested_list/controller/not_interested_controller.dart';
import 'package:matrimony/view/widget/custom_loader/custom_loader.dart';

class NotInterestedRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static HomeController homeController = Get.find<HomeController>();
  static NotInterestedController notInterestedController =
      Get.find<NotInterestedController>();

  static Future<void> notInterestedRepo({required String id}) async {
    showPopUpLoader();
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.notInterested}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      homeController.results = [];
      homeController.pageNum = 1;
      homeController.home();
      notInterestedController.refreshnotInterestedList();
    }
    navigator!.pop();

    TostMessage.toastMessage(message: responseModel.message);
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
