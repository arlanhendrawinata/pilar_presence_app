// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_buttom_navigation.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/my_page_view_controller.dart';

import '../../home/views/home_view.dart';
import '../../user_profile/views/user_profile_view.dart';

class MyPageViewView extends GetView<MyPageViewController> {
  const MyPageViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.presenceC.streamPresence(),
        builder: (context, snapshot) {
          // print("mypageview: ${snapshot.data?.exists}");
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: primaryColor,
              child: const Icon(
                Ionicons.finger_print,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () async {
                if (controller.pageIndexC.pageIndex.value != 1) {
                  await controller.presenceC.todayPresence();
                  if (controller.presenceC.todayPresenceExist != null) {
                    CustomToast.infoToast(
                        "Informasi Kehadiran",
                        "Hari ini Anda telah melakukan absen hadir. Silahkan absen hadir pada hari lain.",
                        context);
                  } else {
                    CustomAlertDialog.attendanceDialog(
                        context: Get.context!,
                        title: "Konfirmasi Kehadiran",
                        message: "Silahkan pilih status kehadiran",
                        onCancel: () => Get.back());
                  }
                } else {
                  CustomToast.dangerToast(
                      "Tidak dapat melakukan absen kehadiran",
                      "Silahkan absen kehadiran pada menu beranda",
                      Get.context!);
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomNavigation(),
            body: PageView(
              pageSnapping: true,
              controller: controller.pageC,
              onPageChanged: (index) {
                controller.pageIndexC.pageIndex.value = index;
              },
              children: const [
                HomeView(),
                UserProfileView(),
              ],
            ),
          );
        });
  }
}
