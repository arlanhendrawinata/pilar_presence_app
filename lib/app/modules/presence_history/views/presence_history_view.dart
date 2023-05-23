import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/presence_history_controller.dart';

class PresenceHistoryView extends GetView<PresenceHistoryController> {
  const PresenceHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histori Kehadiran',
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xfff8dcdf),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Get.dialog(
                Dialog(
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.all(10),
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.range,
                      showActionButtons: true,
                      onCancel: () => Get.back(),
                      onSubmit: (obj) {
                        if (obj != null) {
                          if ((obj as PickerDateRange).endDate != null) {
                            controller.pickDate(obj.startDate!, obj.endDate!);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              icon: Icon(
                Ionicons.options_outline,
                size: 22,
                color: primaryColor,
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
      body: GetBuilder<PresenceHistoryController>(
        builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getPresence(),
          builder: (context, snapshot) {
            if (snapshot.data?.size != 0) {
              // print(snapshot.data?.size);
              List<QueryDocumentSnapshot<Map<String, dynamic>>>? dataPresence =
                  snapshot.data?.docs;

              return RefreshIndicator(
                onRefresh: controller.onRefresh,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: dataPresence?.length,
                  itemBuilder: ((context, index) {
                    Map<String, dynamic>? data = dataPresence?[index].data();
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: data?['checkIn']['presence_status'] != "late"
                                ? AppColor.secondaryExtraSoft
                                : AppColor.softRed),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.PRESENCE_DETAIL,
                              arguments: data),
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
                                          (data?['checkIn'] != null)
                                              ? DateFormat.jm().format(
                                                  DateTime.parse(
                                                      data?['checkIn']['date']))
                                              : "-",
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
                                          (data?['checkOut'] != null)
                                              ? DateFormat.jm().format(
                                                  DateTime.parse(
                                                      data?['checkOut']
                                                          ['date']))
                                              : "-",
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
                                    (data?['date'] != null)
                                        ? DateFormat('EEEE, MMM d, ' 'yyyy')
                                            .format(
                                                DateTime.parse(data?['date']))
                                        : "-",
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
                  }),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Tidak ada histori kehadiran",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
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
