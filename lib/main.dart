import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pilar_presence_app/app/controllers/general_overtime_controller.dart';
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/controllers/presence_controller.dart';
import 'package:pilar_presence_app/app/modules/home/controllers/home_controller.dart';
import 'package:pilar_presence_app/app/modules/myPageView/controllers/my_page_view_controller.dart';
import 'package:pilar_presence_app/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:pilar_presence_app/constant.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

// background notification handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Pilar Kreatif Presence",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FCM subscribe
  await messaging.subscribeToTopic("pilar");

  // foreground notifications
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  // background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // terminate notifications
  await messaging.getInitialMessage().then((message) {
    if (message != null) {
      //
    }
  });

  // device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // bindings
  Get.put(PageIndexController(), permanent: true);
  Get.put(PresenceController(), permanent: true);
  Get.put(GeneralOvertimeController(), permanent: true);
  Get.put(MyPageViewController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(UserProfileController(), permanent: true);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!),
                theme: ThemeData(
                  primarySwatch: Colors.red,
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                home: Scaffold(
                  body: Center(child: Text("loading...")),
                ));
          }
          // print("Main.dart : ${snapshot.data}");
          return GetMaterialApp(
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.red,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: "Pilar Presence App",
            initialRoute: snapshot.data != null
                ? (snapshot.data!.emailVerified != false
                    ? Routes.MY_PAGE_VIEW
                    : Routes.LOGIN)
                : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }),
  );
}
