import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_method.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/api_url_container.dart';
import 'package:matrimony/core/service/api_service.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/not_interested_list/controller/not_interested_controller.dart';

class RemoveNotInterestedRepo {
  static ApiService apiService = ApiService(sharedPreferences: Get.find());

  static HomeController homeController = Get.find<HomeController>();
  static NotInterestedController notInterestedController =
      Get.find<NotInterestedController>();

  static Future<void> removeNotInterestedRepo({required String id}) async {
    String url =
        "${ApiUrlContainer.baseURL}${ApiUrlContainer.notInterestedRemove}/$id";
    String responseMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(
      url,
      responseMethod,
      null,
      passHeader: true,
    );

    if (responseModel.statusCode == 200) {
      homeController.refreshHomeData();
      notInterestedController.refreshnotInterestedList();
      TostMessage.toastMessage(message: responseModel.message);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }
  }
}
