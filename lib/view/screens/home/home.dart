import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/global/push_notification/push_notification.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/home/home_controller/home_controller.dart';
import 'package:matrimony/view/screens/home/inner_widgets/appBar/appbar.dart';
import 'package:matrimony/view/screens/home/inner_widgets/cardDesign/card_design.dart';
import 'package:matrimony/view/screens/home/inner_widgets/drawer/drawer_home.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/nav_bar/nav_bar.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController homeController = HomeController();

  @override
  void initState() {
    PushNotificationHandle.firebaseListenNotification(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Show the exit confirmation dialog
        bool exit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ExitConfirmationDialog();
          },
        );

        // Return true if the user wants to exit, false otherwise
        return exit;
      },
      child: SafeArea(
          top: false,
          child: Scaffold(
              drawer: const HomeDrawer(),
              key: _scaffoldKey,
              bottomNavigationBar: const NavBar(currentIndex: 0),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarHome(scaffoldKey: _scaffoldKey),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: GetBuilder<HomeController>(builder: (controller) {
                        if (controller.results.isEmpty) {
                          return const Center(
                            child: CustomText(
                                fontSize: 16,
                                text: AppStaticStrings.noProfileFound),
                          );
                        }

                        if (controller.isLoading &&
                            controller.dataLoading == false) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (controller.retry) {
                          return Center(
                            child: IconButton(
                              onPressed: () {
                                controller.home();
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              iconSize: 40,
                            ),
                          );
                        }
                        return RefreshIndicator(
                          color: AppColors.pink100,
                          onRefresh: () async {
                            controller.refreshHomeData();
                          },
                          child: GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            primary: false,
                            padding: const EdgeInsets.only(bottom: 20),
                            controller: controller.scrollController,
                            shrinkWrap: true,
                            itemCount: controller.dataLoading
                                ? controller.results.length + 1
                                : controller.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 290,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 16,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              if (index < controller.results.length) {
                                return GestureDetector(
                                  // onTap: () {
                                  //   Get.toNamed(AppRoute.profileDetails,
                                  //       arguments: controller.results[index]);
                                  // },
                                  child: CardDesign(
                                      results: controller.results[index],
                                      userID: controller.results[index].id
                                          .toString(),
                                      photos: controller.results[index].photo!,
                                      name: controller.results[index].name
                                          .toString(),
                                      title:
                                          "${controller.results[index].occupation} ${controller.results[index].dataOfBirth}",
                                      subTitle:
                                          "${controller.results[index].city}, ${controller.results[index].country}",
                                      isPremium:
                                          controller.results[index].payment!),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ))),
    );
  }
}
