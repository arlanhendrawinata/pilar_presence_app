import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_textarea.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/perizinan_cuti_request_controller.dart';

class PerizinanCutiRequestView extends GetView<PerizinanCutiRequestController> {
  const PerizinanCutiRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengajuan Cuti',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextArea(
              controller: controller.ketCutiC,
              label: "Keterangan Cuti",
              hint: "keterangan",
              context: context,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.pickStartDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mulai",
                            style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 11)),
                          ),
                          Obx(
                            () => Text(
                              controller.defDateStart.value,
                              style: TextStyle(
                                  color: controller.defDateStart.value !=
                                          DateFormat.yMd()
                                              .format(DateTime.now())
                                              .replaceAll("/", "-")
                                      ? Colors.black
                                      : AppColor.secondarySoft,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (controller.dateStart != null) {
                        controller.pickEndDate(context);
                      } else {
                        CustomToast.infoToast(
                            "Pengajuan Cuti",
                            "Silahkan mengisi tanggal mulai terlebih dahulu",
                            context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selesai",
                            style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 11)),
                          ),
                          Obx(
                            () => Text(
                              controller.defDateEnd.value,
                              style: TextStyle(
                                  color: controller.defDateEnd.value !=
                                          DateFormat.yMd()
                                              .format(DateTime.now())
                                              .replaceAll("/", "-")
                                      ? Colors.black
                                      : AppColor.secondarySoft,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.requestCuti();
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
                          'Kirim Permintaan Cuti',
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
            ),
          ],
        ),
      ),
    );
  }
}
