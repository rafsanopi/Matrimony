import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/di_service/dependency_injection.dart';
import 'package:matrimony/core/global/no_internet/no_internet.dart';
import 'package:matrimony/core/global/push_notification/push_notification.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:matrimony/core/service/socket_service.dart';
import 'package:matrimony/utils/device_utils.dart';

// getIP() async {
//   final ipv4 = await Ipify.ipv4();
//   print("=========================$ipv4"); // 98.207.254.136

//   final ipv6 = await Ipify.ipv64();
//   print("=============$ipv6"); // 98.207.254.136 or 2a00:1450:400f:80d::200e

//   final ipv4json = await Ipify.ipv64(format: Format.JSON);
//   print(
//       "=============$ipv4json"); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DeviceUtils.lockDevicePortrait();
  DeviceUtils.systemNavigationBarColor();
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  Get.put(NoInternetController(), permanent: true);

  PushNotificationHandle.firebaseinit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBAckgroundHandaler);
  dI.downloadPermission();
  SocketApi.init();

  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> _firebaseMessageBAckgroundHandaler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoute.splashScreen,
        // initialRoute: AppRoute.noInternet,
        navigatorKey: Get.key,
        getPages: AppRoute.routes,
      ),
    );
  }
}
