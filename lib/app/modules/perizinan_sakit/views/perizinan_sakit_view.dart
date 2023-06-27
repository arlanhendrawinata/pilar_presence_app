import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:photo_view/photo_view.dart';
import '../controllers/perizinan_sakit_controller.dart';

class PerizinanSakitView extends GetView<PerizinanSakitController> {
  const PerizinanSakitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perizinan Sakit',
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
              onTap: () => Get.toNamed(Routes.PERIZINAN_SAKIT_REQUEST),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
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
                          Text(
                            "Total Sakit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                          GetBuilder<PerizinanSakitController>(
                            builder: (c) => FutureBuilder(
                              future: controller.totalSakit(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.count}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 10),
                  // Expanded(
                  //   child: Container(
                  //     padding: EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: DecorationImage(
                  //         image: AssetImage('assets/gradient_line_2.jpg'),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Total Cuti Tahun ${DateTime.now().year}",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: Constant.textSize(
                  //                 context: context, fontSize: 12),
                  //           ),
                  //         ),
                  //         GetBuilder<PerizinanSakitController>(
                  //           builder: (c) => FutureBuilder(
                  //             future: controller.cutiTahunan(),
                  //             builder: (context, snapshot) {
                  //               if (snapshot.data?.data()?['amount'] !=
                  //                   null) {
                  //                 return Text(
                  //                   "${snapshot.data!.data()!['amount']}",
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.white60,
                  //                     fontSize: Constant.textSize(
                  //                         context: context, fontSize: 26),
                  //                   ),
                  //                 );
                  //               } else {
                  //                 return Text(
                  //                   "00",
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.white60,
                  //                     fontSize: Constant.textSize(
                  //                         context: context, fontSize: 26),
                  //                   ),
                  //                 );
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
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
                          Text(
                            "Disetujui",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                          GetBuilder<PerizinanSakitController>(
                            builder: (c) => FutureBuilder(
                              future: controller.sakitStatus("approved"),
                              builder: (context, snapshot) {
                                controller.sakitTahunan();
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.count}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
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
                          Text(
                            "Pending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                          GetBuilder<PerizinanSakitController>(
                            builder: (c) => FutureBuilder(
                              future: controller.sakitStatus("pending"),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.count}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
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
                          Text(
                            "Ditolak",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                          GetBuilder<PerizinanSakitController>(
                            builder: (c) => FutureBuilder(
                              future: controller.sakitStatus("rejected"),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.count}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "00",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.allDateSakit(),
                builder: (context, snapshot) {
                  if (snapshot.data?.docs.length != null &&
                      snapshot.data?.docs.length != 0) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        allDatePerizinanSakit = snapshot.data!.docs;
                    return SizedBox(
                      height: Get.height * 0.5,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        itemCount: allDatePerizinanSakit.length,
                        itemBuilder: ((context, index) {
                          Map<String, dynamic> data =
                              allDatePerizinanSakit[index].data();
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppColor.secondaryExtraSoft),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            margin: index != allDatePerizinanSakit.length - 1
                                ? const EdgeInsets.only(bottom: 10)
                                : const EdgeInsets.only(bottom: 0),
                            child: ExpansionTile(
                              leading: (data['status'] == 'pending')
                                  ? Icon(
                                      Ionicons.alarm,
                                      color: AppColor.warning,
                                    )
                                  : (data['status'] == 'rejected')
                                      ? Icon(
                                          Ionicons.close_circle_outline,
                                          color: AppColor.error,
                                        )
                                      : Icon(
                                          Ionicons.checkmark_circle_outline,
                                          color: AppColor.success,
                                        ),
                              shape: Border.all(width: 0, color: Colors.white),
                              title: Text(
                                DateFormat('EEEE, MMM d, ' 'yyyy')
                                    .format(DateTime.parse(data['date'])),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14),
                                ),
                              ),
                              children: [
                                SizedBox(
                                  width: Get.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 1,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: AppColor.secondaryExtraSoft,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Keterangan",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: Constant.textSize(
                                                    context: context,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              "${data['detail']}"
                                                  .toUpperFirstCase(),
                                              style: TextStyle(
                                                color: AppColor.secondarySoft,
                                                fontSize: Constant.textSize(
                                                    context: context,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: Constant.textSize(
                                                    context: context,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              "${data['status']}"
                                                  .toUpperFirstCase(),
                                              style: TextStyle(
                                                color: AppColor.secondarySoft,
                                                fontSize: Constant.textSize(
                                                    context: context,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 6),
                                              backgroundColor: secondaryColor),
                                          onPressed: () => Get.toNamed(
                                              Routes.PHOTO_VIEW,
                                              arguments: data['photoURL']),
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
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
                                  "Data sakit Anda masih kosong.",
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
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
