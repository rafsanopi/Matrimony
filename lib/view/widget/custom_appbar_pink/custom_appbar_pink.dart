import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';

class CustomAppBarPink extends StatefulWidget {
  final String title;
  final VoidCallback onBack;
  final Widget child;
  final Widget? bottomNavBar;
  final bool isBackButton;

  const CustomAppBarPink({
    required this.title,
    required this.onBack,
    required this.child,
    this.bottomNavBar,
    Key? key,
    this.isBackButton = true,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarPinkState createState() => _CustomAppBarPinkState();
}

class _CustomAppBarPinkState extends State<CustomAppBarPink> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.pink100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18, top: 36, left: 10),
              child: Row(
                children: [
                  //========================================Back Button=====================================

                  widget.isBackButton
                      ? ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: AppColors.white100,
                                ),
                                onPressed: () {
                                  widget.onBack();
                                },
                              ),
                            ),
                          ),
                        )
                      : IconButton(onPressed: () {}, icon: const SizedBox()),
                  CustomText(
                    color: AppColors.white100,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    text: widget.title,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.white,
                ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.bottomNavBar,
    );
  }
}
