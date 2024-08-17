import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/date_converter.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/utils/device_utils.dart';
import 'package:matrimony/view/screens/notification/notifiaction_controller/notifiaction_controller.dart';
import 'package:matrimony/view/screens/notification/notifiaction_repo/read_notification.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    DeviceUtils.statusBarColor();
    super.initState();
  }

  // NotificationController notificationController =
  //     Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
            appBar: CustomAppBar(
              ontap: () {
                //notificationController.refreshNotification();
              },
              title: AppStaticStrings.notification,
            ),
            body: GetBuilder<NotificationController>(builder: (controller) {
              return controller.isLoading && controller.dataLoading == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.results.isEmpty
                      ? const Center(
                          child: CustomText(
                            text: AppStaticStrings.noNotification,
                          ),
                        )
                      : RefreshIndicator(
                          color: AppColors.pink100,
                          onRefresh: () async {
                            controller.pageNum = 1;
                            controller.results.clear();
                            controller.notification();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //<<<=============================Read All Notification============================>>>

                              TextButton(
                                  onPressed: () {
                                    ReadNotificationRepo
                                            .readAllNotificationRepo()
                                        .then((value) =>
                                            controller.refreshNotification());
                                  },
                                  child: const CustomText(
                                    textDecoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    text: AppStaticStrings.readAll,
                                  )),

                              //<<<<<<=============================Notification List=====================>>>>>>>

                              Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: controller.scrollController,
                                  itemCount: controller.results.length,
                                  itemBuilder: (context, index) {
                                    int lastIndex =
                                        controller.results.length - 1;
                                    if (index < controller.results.length) {
                                      return InkWell(
                                        onTap: () {
                                          //==========================Navigate to another Screen====================
                                          if (controller.results[index].type ==
                                              "matchRequest") {
                                            Get.toNamed(AppRoute.matchRequest);
                                          }

                                          //==========================Single Read Notification====================

                                          ReadNotificationRepo
                                                  .singleReadNotification(
                                                      userID: controller
                                                          .results[index].id!)
                                              .then((value) => controller
                                                  .refreshNotification());
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(20.w),
                                              color: controller.results[index]
                                                      .viewStatus!
                                                  ? AppColors.black5
                                                  : AppColors.green20,
                                              child: Row(
                                                children: [
                                                  //=================================User Image=============================

                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 16),
                                                    height: 42,
                                                    width: 42,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                controller
                                                                    .results[
                                                                        index]
                                                                    .image![0]
                                                                    .publicFileUrl
                                                                    .toString()))),
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //=================================Message=============================

                                                      CustomText(
                                                        fontSize: 12,
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 3,
                                                        text: controller
                                                            .results[index]
                                                            .message
                                                            .toString(),
                                                      ),

                                                      //=================================Date and Time=============================

                                                      CustomText(
                                                        fontSize: 8,
                                                        color:
                                                            AppColors.black80,
                                                        text: DateConverter
                                                            .dateMonthHourMinite(
                                                                controller
                                                                    .results[
                                                                        index]
                                                                    .createdAt
                                                                    .toString()),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),

                                            //=================================Line=============================

                                            lastIndex == index
                                                ? const SizedBox()
                                                : Container(
                                                    height: 2,
                                                    margin:
                                                        const EdgeInsets.only(),
                                                    color: AppColors.pink20,
                                                  )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
            })));
  }
}
