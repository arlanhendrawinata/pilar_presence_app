import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/overtime_history_controller.dart';

class OvertimeHistoryView extends GetView<OvertimeHistoryController> {
  const OvertimeHistoryView({Key? key}) : super(key: key);
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
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xfff8dcdf),
              borderRadius: BorderRadius.circular(10.r),
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
                size: 22.w,
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
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'OvertimeHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
