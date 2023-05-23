import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/overtime_detail_controller.dart';

class OvertimeDetailView extends GetView<OvertimeDetailController> {
  const OvertimeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Lembur',
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
      body: ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/gradient_line_2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Waktu Lembur",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                          Text(
                            "00:00",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1.5, color: AppColor.secondaryExtraSoft),
                    borderRadius: BorderRadius.circular(10.r),
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
                                "Keterangan Lembur",
                                style: TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            // (controller.data['checkOut'] != null)
                            //     ? "${DateFormat.jm().format(DateTime.parse(controller.data['checkOut']['date']))}"
                            //     : "-",
                            "1 Januari 2023",
                            style: TextStyle(
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
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
                            "Accepted",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 14),
                            ),
                          ),
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
