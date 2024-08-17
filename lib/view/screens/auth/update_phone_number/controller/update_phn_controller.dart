import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class UpdatePhoneController extends GetxController {
  bool isLoading = false;
  TextEditingController updateNumController = TextEditingController();
  TextEditingController countryCodeController =
      TextEditingController(text: "+92");

  updateNumber() async {
    isLoading = true;
    update();

    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(SharedPreferenceHelper.userIdKey);
    String? token = prefs.getString(SharedPreferenceHelper.token);

    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse(
          "${ApiUrlContainer.baseURL}${ApiUrlContainer.updateProfile}$id"),
    );
    Map<String, dynamic> params = {
      "phoneNumber": "${countryCodeController.text}${updateNumController.text}",
    };

    params.forEach((key, value) {
      request.fields[key] = value;
    });

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = "Bearer $token";
    // Send the request
    var response = await request.send();

    String responseBody = await response.stream.bytesToString();

    // Parse the JSON string
    Map<String, dynamic> parsedResponse = jsonDecode(responseBody);

    // Access the "message" field
    String message = parsedResponse['message'];

    if (response.statusCode == 200) {
      isLoading = false;
      TostMessage.toastMessage(message: message);
      debugPrint(
          "Response========================${parsedResponse['data']["attributes"]["phoneNumber"]}}");
      update();

      Get.toNamed(AppRoute.otpVerifyPhn,
          arguments: parsedResponse['data']["attributes"]["phoneNumber"]);

      // SendOtpNum.sendOTP();
    } else {
      TostMessage.toastMessage(message: message);
    }
  }
}
