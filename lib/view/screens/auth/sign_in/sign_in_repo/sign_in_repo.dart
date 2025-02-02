import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/global/device_info/device_info.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepo {
  ApiService apiService;
  SignInRepo({required this.apiService});

  Future<ApiResponseModel> signInRepo({
    required String email,
    required String password,
  }) async {
    String deviceInfo = await getDeviceInfo();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? fcmToken = prefs.getString(SharedPreferenceHelper.fcmToken);

    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.logIn}$deviceInfo&fcmToken=$fcmToken";
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
      "password": password,
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }
}
