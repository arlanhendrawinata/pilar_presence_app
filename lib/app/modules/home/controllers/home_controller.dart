import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/controllers/general_overtime_controller.dart';
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/controllers/presence_controller.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class HomeController extends GetxController {
  RxInt connectionType = 0.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  final pageC = Get.find<PageIndexController>();
  final presenceC = Get.find<PresenceController>();
  final overtimeC = Get.find<GeneralOvertimeController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameC = TextEditingController();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("users").doc(uid).snapshots();
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'hight_importance_channel', 'High Importance Notifications',
      importance: Importance.high, playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return updateState(connectivityResult);
  }

  updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        Get.snackbar('Error', 'Failed to get connection type');
        break;
    }
  }

  @override
  void onInit() async {
    super.onInit();

    getConnectivityType();
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // on foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        RemoteNotification notification = message.notification!;
        // AndroidNotification _android = message.notification!.android!;
        // print('Message also contained a notification: ${_notification.title!}');

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )));
      }
    });
  }

  void getConnectivity() {}

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  void routeToMap() async {
    Map<String, dynamic> dataResponse = await presenceC.determinePosition();
    if (dataResponse["error"] == false) {
      Get.toNamed(Routes.MAP, arguments: dataResponse["position"]);
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "${dataResponse['message']}", Get.context!);
    }
  }
}
