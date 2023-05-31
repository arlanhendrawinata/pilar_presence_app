import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/cuti_tahunan_controller.dart';

class CutiTahunanView extends GetView<CutiTahunanController> {
  const CutiTahunanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cuti Tahunan',
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Select year"),
                  content: SizedBox(
                    height: 300,
                    width: 300,
                    child: YearPicker(
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 17),
                        selectedDate: controller.selectedDate,
                        onChanged: (date) {
                          controller.selectedDate = date;
                          Get.back();
                        }),
                  ),
                ),
              ),
              child: const Icon(
                Ionicons.add_outline,
                size: 22,
                color: Colors.black87,
              ),
            ),
          ),
        ],
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamCutiTahunan(),
          builder: (context, snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? listCutiTahunan =
                snapshot.data?.docs;
            if (listCutiTahunan?.length != 0 &&
                listCutiTahunan?.length != null) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shrinkWrap: true,
                itemCount: (listCutiTahunan?.length != 0 &&
                        listCutiTahunan?.length != null)
                    ? listCutiTahunan?.length
                    : 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5, color: AppColor.secondaryExtraSoft),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Masuk",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 14),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "-",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  Column(
                                    children: [
                                      Text(
                                        "Keluar",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 14),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "-",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  "-",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: Constant.textSize(
                                        context: context, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 4,
                        blurRadius: 4, // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.information_circle_outline,
                        color: infoColor,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Data cuti tahunan Anda masih kosong.",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
