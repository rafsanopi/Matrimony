import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/device_info/device_info.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpOtpRepo {
  ApiService apiService;
  SignUpOtpRepo({required this.apiService});

  Future<ApiResponseModel> signUpOtpRepo({
    required String email,
    required String oneTimeCode,
  }) async {
    String deviceInfo = await getDeviceInfo();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? fcmToken = prefs.getString(SharedPreferenceHelper.fcmToken);

    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.signUpVerifyEmail}?model=$deviceInfo&fcmToken=$fcmToken";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
      "oneTimeCode": oneTimeCode,
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }
}
