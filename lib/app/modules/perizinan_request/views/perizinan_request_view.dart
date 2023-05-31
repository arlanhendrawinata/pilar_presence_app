import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/perizinan_request_controller.dart';
import 'package:intl/intl.dart';

class PerizinanRequestView extends GetView<PerizinanRequestController> {
  const PerizinanRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Permintaan Perizinan',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.ADMIN_MENU),
          icon: const Icon(
            Ionicons.arrow_back,
            color: Colors.black87,
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
        child: Column(
          children: [
            // overtime
            GetBuilder<PerizinanRequestController>(
              builder: (c) => FutureBuilder<List<dynamic>>(
                future: controller.getData("overtime"),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return cardRequest(context, "Lembur", snapshot.data!);
                  } else {
                    return cardRequestIsNull(context, "Lembur");
                  }
                },
              ),
            ),
            GetBuilder<PerizinanRequestController>(
              builder: (c) => FutureBuilder<List<dynamic>>(
                future: controller.getData("cuti"),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return cardRequest(context, "Cuti", snapshot.data!);
                  } else {
                    return cardRequestIsNull(context, "Cuti");
                  }
                },
              ),
            ),
            // SizedBox(height: 20),
            GetBuilder<PerizinanRequestController>(
              builder: (c) => FutureBuilder<List<dynamic>>(
                future: controller.getData("sakit"),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return cardRequest(context, "Sakit", snapshot.data!);
                  } else {
                    return cardRequestIsNull(context, "Sakit");
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget cardRequestIsNull(BuildContext context, String title) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(bottom: 6, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(bottom: 6),
          width: Get.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: AppColor.secondaryExtraSoft),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
              Text(
                "0 Permintaan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cardRequest(
      BuildContext context, String title, List<dynamic> snapshot) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(bottom: 6, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(bottom: 6),
          width: Get.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: AppColor.secondaryExtraSoft),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
              Text(
                "${snapshot.length} Permintaan",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 124,
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: AppColor.secondaryExtraSoft,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/gradient_line.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => {
                      if (title == "Lembur")
                        {
                          CustomAlertDialog.approvalDialog(
                              type: "overtime",
                              isLoading: controller.isLoading,
                              detail: snapshot[index]['detail'],
                              context: context,
                              onApprove: () => controller.approvalPerizinan(
                                  "overtime",
                                  "approve",
                                  snapshot[index]['uid'],
                                  snapshot[index]['date']),
                              onReject: () => controller.approvalPerizinan(
                                  "overtime",
                                  "reject",
                                  snapshot[index]['uid'],
                                  snapshot[index]['date']),
                              onCancel: () => Get.back())
                        }
                      else if (title == "Sakit")
                        CustomAlertDialog.approvalDialog(
                            type: "sakit",
                            isLoading: controller.isLoading,
                            detail: snapshot[index]['detail'],
                            photoURL: snapshot[index]['photoURL'],
                            context: context,
                            onApprove: () => controller.approvalPerizinan(
                                "sakit",
                                "approve",
                                snapshot[index]['uid'],
                                snapshot[index]['date']),
                            onReject: () => controller.approvalPerizinan(
                                "sakit",
                                "reject",
                                snapshot[index]['uid'],
                                snapshot[index]['date']),
                            onCancel: () => Get.back())
                      else
                        {
                          CustomAlertDialog.approvalDialog(
                              type: "cuti",
                              isLoading: controller.isLoading,
                              detail: snapshot[index]['detail'],
                              photoURL: snapshot[index]['photoURL'],
                              context: context,
                              onApprove: () => controller.approvalPerizinan(
                                  "cuti",
                                  "approve",
                                  snapshot[index]['uid'],
                                  snapshot[index]['date']),
                              onReject: () => controller.approvalPerizinan(
                                  "cuti",
                                  "reject",
                                  snapshot[index]['uid'],
                                  snapshot[index]['date']),
                              onCancel: () => Get.back())
                        }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${snapshot[index]['name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                DateFormat('d MMM yyyy').format(
                                    DateTime.parse(snapshot[index]['date'])),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          (title == "Lembur")
                              ? Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Mulai",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          "${snapshot[index]['time_start']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      children: [
                                        Text(
                                          "Selesai",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          "${snapshot[index]['time_end']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : (title == "Sakit")
                                  ? Row(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 6),
                                              backgroundColor: secondaryColor),
                                          onPressed: () =>
                                              CustomAlertDialog.showPhoto(
                                                  context: context,
                                                  photoURL: snapshot[index]
                                                      ['photoURL']),
                                          child: Text(
                                            "Lihat Foto",
                                            style: TextStyle(
                                              fontSize: Constant.textSize(
                                                  context: context,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : (title == "Cuti")
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Mulai",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat.yMd()
                                                      .format(DateTime.parse(
                                                          snapshot[index]
                                                              ['cuti_start']))
                                                      .replaceAll("/", "-"),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Selesai",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat.yMd()
                                                      .format(DateTime.parse(
                                                          snapshot[index]
                                                              ['cuti_end']))
                                                      .replaceAll("/", "-"),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : const Column()
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
