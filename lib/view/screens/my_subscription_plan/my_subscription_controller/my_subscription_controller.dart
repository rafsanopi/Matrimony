import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_model/my_subscription_model.dart';
import 'package:matrimony/view/screens/my_subscription_plan/my_subscription_repo/my_subscription_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySubscriptionController extends GetxController {
  MySubscriptionRepo mySubscriptionRepo =
      MySubscriptionRepo(apiService: Get.find());

  bool isLoading = false;
  bool isPayment = false;
  bool isFreeSubscription = false;

  Attributes attributes = Attributes();

  MySubscriptionModel premiumPackageModel = MySubscriptionModel();

  Future<void> mySubscription() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await mySubscriptionRepo.mySubscriptionRepo();

    if (responseModel.statusCode == 200) {
      premiumPackageModel =
          MySubscriptionModel.fromJson(jsonDecode(responseModel.responseJson));

      Attributes? rawData = premiumPackageModel.data?.attributes;
      if (rawData != null) {
        attributes = rawData;
      }
    }

    isLoading = false;
    update();
  }

  Map<String, dynamic> emytydata = {};

  checkIfSubscriptionExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isPayment = prefs.getBool(SharedPreferenceHelper.isPayment)!;
    isFreeSubscription =
        prefs.getBool(SharedPreferenceHelper.freeSubscription)!;

    debugPrint("Payment==============>>>>>>>>>>>$isPayment");
    debugPrint(
        "isFreeSubscription==============>>>>>>>>>>>$isFreeSubscription");

    if (isPayment || isFreeSubscription) {
      mySubscription();
    } else {
      TostMessage.toastMessage(message: AppStaticStrings.noSubsCription);
    }
  }

  @override
  void onInit() {
    //  checkIfSubscriptionExist();
    checkIfSubscriptionExist();
    super.onInit();
  }
}
