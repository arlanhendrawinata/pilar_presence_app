import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/admin_menu_controller.dart';

class AdminMenuView extends GetView<AdminMenuController> {
  const AdminMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Menu',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: ScreenUtilInit(
          builder: (context, child) => IconButton(
            onPressed: () => Get.offAllNamed(Routes.MY_PAGE_VIEW),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.PERIZINAN_REQUEST),
                child: Container(
                  width: Get.width,
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
                      //* Total Permintaan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(200, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Ionicons.send_outline,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Permintaan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "Perizinan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GetBuilder<AdminMenuController>(
                            builder: (c) => FutureBuilder<List<dynamic>>(
                              future: controller.getData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  String countPerizinanRequest = snapshot
                                      .data!.length
                                      .toString()
                                      .padLeft(2, '0');
                                  return Text(
                                    countPerizinanRequest,
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
                    ],
                  ),
                ),
              ),
              //* End Total Permintaan
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Get.toNamed(Routes.MONITORING),
                          child: Container(
                            width: Get.width * 0.45,
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
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              200, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(
                                        Ionicons.eye_outline,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monitoring",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "Karyawan",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GetBuilder<AdminMenuController>(
                                          builder: (c) => FutureBuilder<int>(
                                              future:
                                                  controller.employeePresence(),
                                              builder: (context, snapshot) {
                                                String countPresence = snapshot
                                                    .data
                                                    .toString()
                                                    .padLeft(2, '0');
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    countPresence,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white60,
                                                      fontSize:
                                                          Constant.textSize(
                                                              context: context,
                                                              fontSize: 26),
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                    "00",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white60,
                                                      fontSize:
                                                          Constant.textSize(
                                                              context: context,
                                                              fontSize: 26),
                                                    ),
                                                  );
                                                }
                                              })),
                                      Text(
                                        "Karyawan Hadir",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.REPORT),
                          child: Container(
                            width: Get.width * 0.45,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/gradient_line_2.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Ionicons.stats_chart_outline,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Laporan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.textSize(
                                        context: context, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Get.toNamed(Routes.CUTI_TAHUNAN),
                          child: Container(
                            width: Get.width * 0.45,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/gradient_line_2.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Ionicons.airplane_outline,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cuti",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      "Tahunan",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.MANAGEMENT_USER),
                          child: Container(
                            width: Get.width * 0.45,
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
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              200, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(
                                        Ionicons.person_outline,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Manajemen",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          "Pengguna",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                          future: controller.getActiveUser(),
                                          builder: (context, snapshot) {
                                            if (snapshot.data != null) {
                                              return Text(
                                                snapshot.data!.length
                                                    .toString()
                                                    .padLeft(2, '0'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white60,
                                                  fontSize: Constant.textSize(
                                                      context: context,
                                                      fontSize: 26),
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                "00",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white60,
                                                  fontSize: Constant.textSize(
                                                      context: context,
                                                      fontSize: 26),
                                                ),
                                              );
                                            }
                                          }),
                                      Text(
                                        "Pengguna Aktif",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => Get.toNamed(Routes.MANAGEMENT_ANNOUNCEMENT),
                child: Container(
                  width: Get.width,
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
                      //* Total Permintaan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(200, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Ionicons.megaphone_outline,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manajemen",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "Pengumuman",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          FutureBuilder(
                              future: controller.countAnnouncement(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  int count = snapshot.data!.count;
                                  return Text(
                                    count.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white60,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 26),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ],
                      ),
                    ],
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
