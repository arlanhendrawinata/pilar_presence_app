import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtilInit(
            builder: (context, child) => Text(
              'Pengumuman',
              style: TextStyle(
                color: AppColor.secondary,
                fontSize: Constant.textSize(context: context, fontSize: 14),
              ),
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
            ScreenUtilInit(
              minTextAdapt: true,
              builder: (context, child) => Container(
                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: Color(0xfff8dcdf),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () => print("filter"),
                  icon: Icon(
                    Ionicons.options_outline,
                    size: 22.w,
                    color: primaryColor,
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: AppColor.secondaryExtraSoft,
            ),
          ),
        ),
        body: ScreenUtilInit(
          minTextAdapt: true,
          builder: (context, child) => Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    // margin: EdgeInsets.all(20),
                    margin: EdgeInsets.only(
                        bottom: 20.h, left: 20.w, right: 20.w, top: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 4,
                          blurRadius: 4, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "Libur",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "How Facebook Preys on Our Mental Health",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: TextStyle(
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Friday, Dec 02, 2022",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                                color: BlackSoftColor,
                              ),
                            ),
                            Text(
                              "11:45 PM",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                                color: BlackSoftColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
            ),
          ),
        ));
  }
}
