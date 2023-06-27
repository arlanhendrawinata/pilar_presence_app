import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_datepicker.dart';
import 'package:pilar_presence_app/app/widgets/custom_textarea.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/overtime_request_controller.dart';

class OvertimeRequestView extends GetView<OvertimeRequestController> {
  const OvertimeRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Permintaan Lembur',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Ionicons.arrow_back,
            color: Colors.black87,
            size: 22,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                        controller: controller.dateC,
                        label: "Tanggal",
                        hint: "20/04/2022",
                        context: context),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xfff8dcdf),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.pickDate(
                          context,
                          DateTime.now(),
                          DateTime(DateTime.now().year),
                          DateTime(DateTime.now().year + 2),
                        );
                      },
                      icon: Icon(
                        Ionicons.calendar,
                        size: 22,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextArea(
                  context: context,
                  controller: controller.overtimeDetailC,
                  label: "Keterangan Lembur",
                  hint: "keterangan"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (controller.dateC.text != "") {
                          controller.getTime(context, controller.timeStart);
                        } else {
                          CustomToast.infoToast(
                              "Tanggal Kosong",
                              "Silahkan memasukkan tanggal terlebih dahulu pada kolom input tanggal.",
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
                              "Mulai",
                              style: TextStyle(
                                  color: AppColor.secondarySoft,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 11)),
                            ),
                            Obx(
                              () => Text(
                                controller.timeStart.value,
                                style: TextStyle(
                                    color: AppColor.secondarySoft,
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
                        if (controller.dateC.text != "") {
                          controller.getTime(context, controller.timeEnd);
                          // DatePicker.showTimePicker(
                          //   context,
                          //   showSecondsColumn: false,
                          //   showTitleActions: true,
                          //   currentTime:
                          //       DateTime.parse("${controller.dateC.text}"),
                          //   onConfirm: (time) {
                          //     controller.dateTimeEnd = "${time}";
                          //     controller.timeEnd?.value =
                          //         "${controller.timeFormat.format(time)}";
                          //   },
                          // );
                        } else {
                          CustomToast.infoToast(
                              "Tanggal Kosong",
                              "Silahkan memasukkan tanggal terlebih dahulu pada kolom input tanggal.",
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
                                controller.timeEnd.value,
                                style: TextStyle(
                                    color: AppColor.secondarySoft,
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
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.requestOvertime();
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
                            'Kirim Permintaan Lembur',
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
      ),
    );
  }
}
