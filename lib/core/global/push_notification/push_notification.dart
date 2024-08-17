import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:matrimony/core/helper/sharedpreference_helper.dart';
import 'package:matrimony/core/route/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

class PushNotificationHandle {
  //==================Request for permission and Generate FCM token=================
  static firebaseinit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted permission==================>>>>>>>>>>>>: ${settings.authorizationStatus}');

    String? token = await messaging.getToken();

    await prefs.setString(SharedPreferenceHelper.fcmToken, token!);

    debugPrint('FCM TOKEN <<<<<<<=====>>>>>>> $token');
  }

  //==================Listen Firebase Notification in every State of the app=================

  static firebaseListenNotification({required BuildContext context}) async {
    FirebaseMessaging.instance.subscribeToTopic('signedInUsers');
//============>>>>>Listen Notification when the app is in foreground state<<<<<<<===========

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(
          "Firebase onMessage=============================>>>>>>>>>>>>>>>>>>${message.data}");

      initLocalNotification(message: message);

      showTextNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
      );
    });

//============>>>>>Listen Notification when the app is in BackGround state<<<<<<<===========

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message: message);
    });

//============>>>>>Listen Notification when the app is in Terminated state<<<<<<<===========

    RemoteMessage? terminatedMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (terminatedMessage != null) {
      handleMessage(message: terminatedMessage);
    }
  }

  //============================Initialize Local Notification=======================

  static Future<void> initLocalNotification(
      {required RemoteMessage message}) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/launcher_icon");

    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await fln.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? paylod) {
        debugPrint("==================>>>>>>>>>paylod hitted");
        handleMessage(message: message);
      },
    );
  }

  static handleMessage({required RemoteMessage message}) {
    Map<String, dynamic> data = message.data;

    String type = data["type"];

    if (type == "inbox") {
      SenderUser senderInfo =
          SenderUser.fromJson(jsonDecode(data["senderUser"]));

      MessageSent messageInfo =
          MessageSent.fromJson(jsonDecode(data["messageSent"]));
      Get.toNamed(AppRoute.inbox, arguments: [
        senderInfo.name,
        senderInfo.photo![0].publicFileUrl,
        messageInfo.sender
      ], parameters: {
        "chatId": messageInfo.chat!
      });
    } else if (type == "matchRequest") {
      Get.toNamed(AppRoute.matchRequest);
    }
  }

// <-------------------------- Show Text Notification  --------------------------->
  static Future<void> showTextNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'notification', // meta-data android value
      'notification', // meta-data android value
      playSound: true,
      importance: Importance.low,
      priority: Priority.low,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

//======================================Inbox Chat paylod model==============================

class ChatMessage {
  final String? type;
  final MessageSent? messageSent;
  final SenderUser? senderUser;

  ChatMessage({
    this.type,
    this.messageSent,
    this.senderUser,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      type: json['type'] as String?,
      messageSent: json['messageSent'] != null
          ? MessageSent.fromJson(json['messageSent'])
          : null,
      senderUser: json['senderUser'] != null
          ? SenderUser.fromJson(json['senderUser'])
          : null,
    );
  }
}

class MessageSent {
  final String? sender;
  final String? chat;
  final String? id;
  final Content? content;

  MessageSent({
    this.sender,
    this.chat,
    this.id,
    this.content,
  });

  factory MessageSent.fromJson(Map<String, dynamic> json) {
    return MessageSent(
      sender: json['sender'] as String?,
      chat: json['chat'] as String?,
      id: json['id'] as String?,
      content:
          json['content'] != null ? Content.fromJson(json['content']) : null,
    );
  }
}

class Content {
  final String? messageType;
  final String? message;

  Content({
    this.messageType,
    this.message,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      messageType: json['messageType'] as String?,
      message: json['message'] as String?,
    );
  }
}

class SenderUser {
  final String? name;
  final String? id;
  final String? habits;
  final String? education;
  final String? occupation;
  final String? brothers;
  final List<Photo>? photo;
  // Add other fields as needed

  SenderUser(
      {this.name,
      this.id,
      this.habits,
      this.education,
      this.occupation,
      this.brothers,
      this.photo
      // Add other fields as needed
      });

  factory SenderUser.fromJson(Map<String, dynamic> json) {
    return SenderUser(
      name: json['name'] as String?,
      id: json['_id'] as String?,
      habits: json['habits'] as String?,
      education: json['education'] as String?,
      occupation: json['occupation'] as String?,
      brothers: json['brothers'] as String?,
      photo: json["photo"] == null
          ? []
          : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
      // Add other fields as needed
    );
  }
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
