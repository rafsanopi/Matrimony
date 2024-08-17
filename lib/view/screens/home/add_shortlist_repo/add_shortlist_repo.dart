import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_controller/short_listed_profile_controller.dart';
import 'package:matrimony/view/widget/custom_loader/custom_loader.dart';

class AddShortListRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  //Update Short List
  static ShortListProfileController shortListProfileController =
      Get.find<ShortListProfileController>();

  static HomeController homeController = Get.find<HomeController>();

  static Future<void> addShortListRepo({required String id}) async {
    showPopUpLoader();
    String url = "${ApiUrlContainer.baseURL}${ApiUrlContainer.addToShortlist}";
    String responseMethod = ApiResponseMethod.postMethod;

    Map<String, String> body = {"profileId": id};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, body, passHeader: true, isRawData: true);

    if (responseModel.statusCode == 201) {
      shortListProfileController.refreshShortList();
      homeController.home();
    }

    TostMessage.toastMessage(message: responseModel.message);
    navigator!.pop();
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
