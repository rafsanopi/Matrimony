import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/button/loading_button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/number_verify/otp_controller/otp_controller.dart';
import 'package:matrimony/view/screens/auth/sign_up/screens/number_verify/send_otp_repo/send_otp_repo.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyPhn extends StatefulWidget {
  const OtpVerifyPhn({
    super.key,
  });

  @override
  State<OtpVerifyPhn> createState() => _OtpVerifyPhnState();
}

class _OtpVerifyPhnState extends State<OtpVerifyPhn> {
  final TextEditingController pinController = TextEditingController();
  int _secondsRemaining = 60;
  late Timer _timer;

  String phoneNumber = "";

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    phoneNumber = Get.arguments;
    SendOtpNum.sendOTP();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhnVerifyController>(builder: (controller) {
      return CustomAppBarPink(
          isBackButton: false,
          bottomNavBar: controller.isLoading
              ? const CustomLoadingButton(
                  bottom: 24,
                  left: 20,
                  right: 20,
                )
              : CustomButton(
                  text: AppStaticStrings.verify,
                  bottom: 24,
                  left: 20,
                  right: 20,
                  ontap: () {
                    controller.verifyPhnOtp();
                  }),
          title: AppStaticStrings.oTPVerify,
          onBack: () {
            Get.back();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //==========================Please enter OTP text========================
                  CustomText(
                    maxLines: 2,
                    top: 44,
                    textAlign: TextAlign.left,
                    fontSize: 16.w,
                    color: AppColors.black100,
                    text:
                        "${AppStaticStrings.pleaseentertheOTpPhn} $phoneNumber",
                  ),

                  //==========================Edit Number========================

                  GestureDetector(
                    onTap: () {
                      // controller.updatePhnNum();
                      Get.toNamed(AppRoute.updateNumber);
                    },
                    child: CustomText(
                      textDecoration: TextDecoration.underline,
                      maxLines: 2,
                      top: 10.h,
                      bottom: 16,
                      textAlign: TextAlign.left,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black80,
                      text: AppStaticStrings.editnumber,
                    ),
                  ),

                  SizedBox(
                    height: 60,
                    child: PinCodeTextField(
                      cursorColor: AppColors.black40,
                      keyboardType: TextInputType.number,
                      controller: pinController,
                      appContext: (context),
                      onCompleted: (value) {
                        controller.oneTimeCode = value.toString();
                      },
                      autoFocus: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 56,
                        fieldWidth: 44,
                        activeFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        selectedColor: AppColors.black100,
                        activeColor: AppColors.pink60,
                        inactiveColor: AppColors.black10,
                      ),
                      length: 6,
                      enableActiveFill: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          color: AppColors.black80,
                          text: AppStaticStrings.didNotGet,
                        ),

                        //=========================Resend OTP===========================
                        InkWell(
                          onTap: () {
                            if (_secondsRemaining == 0) {
                              _secondsRemaining = 60;
                              startTimer();
                              SendOtpNum.sendOTP().then((value) {
                                if (value == false) {
                                  setState(() {
                                    _timer.cancel();
                                    _secondsRemaining = 0;
                                  });
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              textDecoration: _secondsRemaining == 0
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              //  fontSize: 16,
                              //  fontWeight: FontWeight.w500,
                              color: AppColors.black80,
                              text: _secondsRemaining == 0
                                  ? AppStaticStrings.resendOTP
                                  : "${AppStaticStrings.resendOTPIn} $_secondsRemaining",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
