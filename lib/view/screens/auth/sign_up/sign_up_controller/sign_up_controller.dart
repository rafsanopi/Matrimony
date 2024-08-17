import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/api_response_model.dart';
import 'package:matrimony/core/global/height_calculator/height_calculator.dart';
import 'package:matrimony/core/global/religion_caste_sect.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/app_utils.dart';
import 'package:matrimony/view/screens/auth/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class SignUpController extends GetxController {
  SignUpRepo signUpRepo = SignUpRepo(apiService: Get.find());

  updateCreateProFor({required String getCreateProFor}) {
    createProFor = getCreateProFor;

    update();
  }

  //Create Profile For
  String createProFor = "Self";

  //Personal Details
  int selectedMonth = 0;
  int selectedYear = 0;

  TextEditingController datesController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController ftController = TextEditingController();
  TextEditingController incController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String countryValue = "Country";
  String stateValue = "State";
  String cityValue = "City";

  //Carrer Details
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController higherEducationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController incomeController = TextEditingController();

  //Social Details
  String maritalStatus = "Unmarried";
  TextEditingController motherTongueController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController sectController = TextEditingController();
  TextEditingController castSectController = TextEditingController();

  //LogIn Details
  TextEditingController nameController = TextEditingController();
  TextEditingController countryCodeController =
      TextEditingController(text: "+92");
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;
  bool isCarrierLoading = false;

  bool vpn = true;

  static const methodChannel = MethodChannel("method.com/vpn");

  //Check if VPN is connected then Sign IN or Show Warning

  Future confirMationPopUP() async {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white100,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(20.w),
            height: 160.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //=======================Current text====================
                CustomText(
                  color: AppColors.black60,
                  fontSize: 12.w,
                  text: AppStaticStrings.isThisCurrect,
                ),
                SizedBox(
                  height: 5.h,
                ),
                //=======================Show email address====================
                CustomText(
                  color: AppColors.black80,
                  textAlign: TextAlign.left,
                  fontSize: 14.w,
                  text: emailController.text,
                ),
                //=======================Show phone Number====================

                CustomText(
                  color: AppColors.black80,
                  textAlign: TextAlign.left,
                  fontSize: 14.w,
                  text:
                      "${countryCodeController.text}${phoneNumController.text}",
                ),
                const Expanded(child: SizedBox()),

                //=======================Buttons====================

                Row(
                  children: [
                    //=======================Edit button====================

                    Expanded(
                        child: CustomButton(
                            text: AppStaticStrings.edit,
                            height: 30,
                            ontap: () {
                              navigator!.pop();
                            })),
                    SizedBox(
                      width: 10.w,
                    ),
                    //=======================Yes button====================

                    Expanded(
                        child: CustomButton(
                            text: AppStaticStrings.yes,
                            height: 30,
                            ontap: () async {
                              final bool checkVPN = await methodChannel
                                  .invokeMethod("isVpnConnected");
                              vpn = checkVPN;
                              update();

                              if (vpn) {
                                TostMessage.snackBar(
                                    title: AppStaticStrings.error,
                                    message: AppStaticStrings.vpnDetected);
                              } else {
                                navigator!.pop();
                                signUpUser();
                              }
                            }))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> signUpUser() async {
    isLoading = true;
    update();

    String height = HeightConverter.feetAndInchesToCentimeters(
        "${ftController.text} ${incController.text}");

    ApiResponseModel responseModel = await signUpRepo.createUser(
        name: nameController.text,
        email: emailController.text,
        password: passController.text,
        phoneNumber: "${countryCodeController.text}${phoneNumController.text}",
        gender: genderController.text,
        profileFor: createProFor,
        dataOfBirth:
            "${datesController.text} ${monthController.text} ${yearController.text}",
        height: height,
        country: countryValue,
        city: cityValue,
        state: stateValue,
        residentialStatus: residenceController.text,
        education: higherEducationController.text,
        workExperience: workExperienceController.text,
        occupation: occupationController.text,
        income: incomeController.text,
        maritalStatus: maritalStatus,
        motherTongue: motherTongueController.text,
        religion: religionController.text,
        caste: castSectController.text,
        sect: ReligionSectCaste.casteSect);

    if (responseModel.statusCode == 201) {
      TostMessage.toastMessage(
          message: AppStaticStrings.anOtpHasBeenSentToYourEmailAddress);

      Get.toNamed(AppRoute.otpSignUp, arguments: emailController.text);
    } else {
      TostMessage.toastMessage(message: responseModel.message);
    }

    isLoading = false;
    update();
  }
}
