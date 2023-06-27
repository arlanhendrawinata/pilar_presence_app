import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:intl/intl.dart';
import '../controllers/monitoring_controller.dart';

class MonitoringView extends GetView<MonitoringController> {
  const MonitoringView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Monitoring Karyawan',
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
          child: GetBuilder<MonitoringController>(
            builder: (c) => FutureBuilder(
              future: controller.getEmployeeList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length != 0) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5, color: AppColor.secondaryExtraSoft),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                        future: controller.getUserData(
                                            snapshot.data![index]['uid']),
                                        builder: (context, snapshot) => Text(
                                          "${snapshot.data}",
                                          softWrap: true,
                                          style: TextStyle(
                                            color: AppColor.secondary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index]["status"]}",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: AppColor.secondary,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: snapshot.data![index]['checkIn']
                                                  ['presence_status'] ==
                                              'late'
                                          ? AppColor.errorSoft
                                          : AppColor.successSoft),
                                  child: Text(
                                    snapshot.data![index]['checkIn']
                                                ['presence_status'] ==
                                            'late'
                                        ? 'Telat'
                                        : 'Tepat Waktu',
                                    style: TextStyle(
                                      color: snapshot.data![index]['checkIn']
                                                  ['presence_status'] ==
                                              'late'
                                          ? AppColor.error
                                          : AppColor.success,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Map<String, dynamic> data =
                                        snapshot.data![index];
                                    // print(data);
                                    Get.toNamed(Routes.MAP, arguments: data);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/gradient_line_2.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      Ionicons.map,
                                      color: Colors.white60,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                  image: AssetImage('assets/gradient_line.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Masuk",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        DateFormat.jm().format(DateTime.parse(
                                            snapshot.data![index]['checkIn']
                                                ['date'])),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.white24,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Keluar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (snapshot.data![index]['checkOut'] !=
                                                null)
                                            ? DateFormat.jm().format(
                                                DateTime.parse(
                                                    snapshot.data![index]
                                                        ['checkOut']['date']))
                                            : "-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
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
                                    "Belum ada karyawan yang melakukan absen kehadiran.",
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
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ));
  }
}
