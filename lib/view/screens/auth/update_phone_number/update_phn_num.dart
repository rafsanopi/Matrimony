import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/auth/update_phone_number/controller/update_phn_controller.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar_pink/custom_appbar_pink.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class UpdatePhone extends StatelessWidget {
  const UpdatePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarPink(
      onBack: () {
        navigator!.pop();
      },
      title: AppStaticStrings.updatePhnNum,
      bottomNavBar: GetBuilder<UpdatePhoneController>(builder: (controller) {
        return CustomButton(
            text: AppStaticStrings.update,
            left: 20,
            right: 20,
            bottom: 20,
            ontap: () {
              controller.updateNumber();
            });
      }),
      child: GetBuilder<UpdatePhoneController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //=============================Phone Number===========================

              CustomText(
                top: 16,
                text: AppStaticStrings.phoneNumber,
                bottom: 16.h,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //=============================Country Code Picker===========================

                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.black10)),
                      child: CountryCodePicker(
                        onChanged: (value) {
                          controller.countryCodeController.text =
                              value.dialCode.toString();
                        },
                        initialSelection: 'PK',
                        // Change favorite countries to Pakistan and another country of your choice
                        favorite: const ['+92', 'PK'],

                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      textEditingController: controller.updateNumController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppStaticStrings.fieldCantBeEmpty;
                        } else {
                          return null;
                        }
                      },
                      readOnly: false,
                      hintText: AppStaticStrings.enterYourPhoneNumber,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
