import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/notification/notifiaction_controller/notifiaction_controller.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';
import 'package:badges/badges.dart' as badges;

class AppBarHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const AppBarHome({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 44),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Drawer button
            IconButton(
              icon: const Icon(
                Icons.menu,
                // color: AppColors.white100,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),

            //Logo and Name

            const Row(
              children: [
                CustomImage(
                  size: 24,
                  imageSrc: AppIcons.logo,
                  imageType: ImageType.png,
                ),
                SizedBox(
                  width: 8,
                ),
                CustomText(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.pink100,
                  text: AppStaticStrings.shaadiiBiyaahNoSpace,
                )
              ],
            ),
            //Logo and Name

            Row(
              children: [
                //Search
                IconButton(
                  icon: const Icon(
                    Icons.search_sharp,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoute.search);
                  },
                ),

                const SizedBox(
                  width: 16,
                ),

                //=========================Notificastion Icon=======================

                // IconButton(
                //   icon: const Icon(
                //     Icons.notifications_outlined,
                //   ),
                //   onPressed: () {
                //     Get.toNamed(AppRoute.notification);
                //   },
                // ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: GetBuilder<NotificationController>(
                    builder: (controller) {
                      if (controller.isLoading) {
                        return IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoute.notification);
                          },
                        );
                      }
                      return badges.Badge(
                        onTap: () {
                          Get.toNamed(AppRoute.notification);
                        },
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: AppColors.pink80,
                        ),
                        showBadge: controller.unReadCount == 0 ? false : true,
                        badgeContent: controller.isLoading
                            ? const CustomText(
                                text: "0",
                                color: AppColors.white100,
                              )
                            : CustomText(
                                fontSize: 12.w,
                                text: controller.unReadCount.toString(),
                                color: AppColors.white100,
                              ),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.notification);
                          },
                          child: Icon(
                            size: 26.w,
                            Icons.notifications_outlined,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
