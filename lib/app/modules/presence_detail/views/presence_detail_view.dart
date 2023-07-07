import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:intl/intl.dart';

import '../controllers/presence_detail_controller.dart';

class PresenceDetailView extends GetView<PresenceDetailController> {
  const PresenceDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Kehadiran',
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
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // =============== CHECKIN =============== //
            IntrinsicHeight(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/gradient_line_2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                              ),
                            ),
                            Text(
                              (controller.data['checkIn'] != null)
                                  ? DateFormat.jm().format(DateTime.parse(
                                      controller.data['checkIn']['date']))
                                  : "-",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          (controller.data['checkIn'] != null)
                              ? DateFormat('EEEE, MMM d, ' 'yyyy').format(
                                  DateTime.parse(
                                      controller.data['checkIn']['date']))
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkIn'] != null)
                              ? "${controller.data['status']}"
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jarak",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkIn'] != null)
                              ? distanceCalculate(
                                  controller.data['checkIn']['distance'])
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status Kehadiran",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkIn'] != null)
                              ? controller.data['checkIn']['presence_status'] !=
                                      'late'
                                  ? 'Tepat Waktu'
                                  : 'Telat'
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkIn'] != null)
                              ? "${controller.data['checkIn']['address']}"
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        (controller.data['status'] == "Dinas Luar")
                            ? TextButton(
                                style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 6),
                                    backgroundColor: secondaryColor),
                                onPressed: () => Get.toNamed(Routes.PHOTO_VIEW,
                                    arguments: controller.data['checkIn']
                                        ['photoURL']),
                                child: Text(
                                  "Lihat Foto",
                                  style: TextStyle(
                                    fontSize: Constant.textSize(
                                        context: context, fontSize: 13),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // =============== CHECKOUT =============== //
            IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 1.5, color: AppColor.secondaryExtraSoft),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Keluar",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                              ),
                            ),
                            Text(
                              (controller.data['checkOut'] != null)
                                  ? DateFormat.jm().format(DateTime.parse(
                                      controller.data['checkOut']['date']))
                                  : "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          (controller.data['checkOut'] != null)
                              ? DateFormat('EEEE, MMM d, ' 'yyyy').format(
                                  DateTime.parse(
                                      controller.data['checkOut']['date']))
                              : "-",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkOut'] != null)
                              ? "${controller.data['status']}"
                              : "-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alamat",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkOut'] != null)
                              ? "${controller.data['checkOut']['address']}"
                              : "-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jarak",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        Text(
                          (controller.data['checkOut'] != null)
                              ? distanceCalculate(
                                  controller.data['checkOut']['distance'])
                              : "-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    (controller.data['checkOut'] != null)
                        ? Column(
                            children: [
                              (controller.data['status'] == "Dinas Luar")
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 6),
                                          backgroundColor: secondaryColor),
                                      onPressed: () => Get.toNamed(
                                          Routes.PHOTO_VIEW,
                                          arguments: controller.data['checkOut']
                                              ['photoURL']),
                                      child: Text(
                                        "Lihat Foto",
                                        style: TextStyle(
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 13),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String distanceCalculate(double distance) {
    int distanceCalculation = (distance.round() / 1000).round();
    if (distance.round() >= 1000) {
      return "${distanceCalculation}km";
    } else {
      return "${distanceCalculation}m";
    }
  }
}
