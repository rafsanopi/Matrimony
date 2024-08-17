import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/not_interested_list/controller/not_interested_controller.dart';
import 'package:matrimony/view/screens/not_interested_list/repo/remove_not_interested.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/request_card/request_card.dart';

class NotInterestedList extends StatelessWidget {
  const NotInterestedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStaticStrings.notInterestedProfiles,
      ),
      body: GetBuilder<NotInterestedController>(builder: (controller) {
        return controller.isLoading && controller.dataLoading == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.attributes.isEmpty
                ? const Center(
                    child: CustomText(
                      text: AppStaticStrings.noProfileFound,
                    ),
                  )
                : RefreshIndicator(
                    color: AppColors.pink100,
                    onRefresh: () async {
                      controller.refreshnotInterestedList();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.dataLoading
                              ? controller.attributes.length + 1
                              : controller.attributes.length,
                          itemBuilder: (context, index) {
                            if (index < controller.attributes.length) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.profileDetails,
                                      arguments: controller
                                          .attributes[index].profileId);
                                },
                                child: RequestCard(
                                    button0Ontap: () {
                                      RemoveNotInterestedRepo
                                          .removeNotInterestedRepo(
                                              id: controller
                                                  .attributes[index].id!);

                                      debugPrint(
                                          "${controller.attributes[index].id}");
                                    },
                                    button0Title: AppStaticStrings.remove,
                                    name: controller
                                        .attributes[index].profileId!.name
                                        .toString(),
                                    title:
                                        "${controller.attributes[index].profileId!.occupation}  ${controller.attributes[index].profileId!.age}",
                                    subTitle:
                                        "${controller.attributes[index].profileId!.country}",
                                    proPic: controller.attributes[index]
                                        .profileId!.photo![0].publicFileUrl
                                        .toString()),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        )),
                  );
      }),
    );
  }
}
