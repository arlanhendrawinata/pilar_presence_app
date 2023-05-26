import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/constant.dart';

class CustomToast {
  static successToast(String? title, String? message, BuildContext context) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.checkmark_circle_outline,
            color: successColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Berhasil",
                    style: TextStyle(
                      color: successColor,
                      fontWeight: FontWeight.w500,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  message ?? "Isi pesan berhasil anda disini",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 8,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      snackPosition: SnackPosition.TOP,
    );
  }

  static dangerToast(String? title, String? message, BuildContext context) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.close_circle_outline,
            color: dangerColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Berhasil",
                    style: TextStyle(
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  message ?? "Isi pesan berhasil anda disini",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 8,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      snackPosition: SnackPosition.TOP,
    );
  }

  static infoToast(String? title, String? message, BuildContext context) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.horizontal,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.information_circle_outline,
            color: infoColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    title ?? "Pemberitahuan",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  message ?? "Isi pesan berhasil anda disini",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 8,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      snackPosition: SnackPosition.TOP,
    );
  }
}
