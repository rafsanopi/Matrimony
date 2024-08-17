import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/short_listed_profile/short_listed_profile_controller/short_listed_profile_controller.dart';

class RemoveShortListRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static ShortListProfileController shortListProfileController =
      Get.find<ShortListProfileController>();

  static Future<void> removeShortListRepo({required String id}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.removeShortList}/$id";
    String responseMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 200) {
      shortListProfileController.refreshShortList();
      TostMessage.toastMessage(message: responseModel.message);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }
  }
}
