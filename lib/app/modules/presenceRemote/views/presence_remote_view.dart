import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/presence_remote_controller.dart';

class PresenceRemoteView extends GetView<PresenceRemoteController> {
  const PresenceRemoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imageUrl = "http://via.placeholder.com/200x150";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Absen Kehadiran Dinas Luar',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: ScreenUtilInit(
          builder: (context, child) => IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Ionicons.arrow_back,
              color: Colors.black87,
              size: 22.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: Get.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Absen kehadiran",
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Silahkan melakukan foto diri untuk melakukan absen kehadiran",
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              // content camera
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.pickImage(), // pick image
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          width: Get.width,
                          height: 200,
                          child: Obx(
                            () => (controller.image.value.path != "")
                                ? Image.file(
                                    controller.image.value,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.grey,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // button
            TextButton(
              onPressed: () {
                controller.image.value = File("");
              },
              child: Text(
                "Hapus gambar",
                style: TextStyle(
                  color: softBlueColor,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // button absen kehadiran
            SizedBox(
              height: 50,
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.value != true) {
                      if (controller.image.value.path != "") {
                        CustomAlertDialog.showDialog(
                            context: Get.context!,
                            title:
                                "Apakah Anda yakin ingin melakukan absen 'Masuk' ?",
                            message:
                                "Silahkan konfirmasi terlebih dahulu sebelum melakukan absen kehadiran",
                            isLoading: controller.isLoading,
                            onConfirm: () => controller.uploadImage(),
                            onCancel: () => Get.back());
                      } else {
                        CustomToast.infoToast(
                            "Foto diri masih kosong",
                            "Silahkan foto diri terlebih dahulu sebelum melakukan absen kehadiran",
                            Get.context!);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    // padding: EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: (controller.isLoading.isFalse)
                      ? Text(
                          'Absen Kehadiran',
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        )
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
