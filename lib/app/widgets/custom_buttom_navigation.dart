import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/modules/myPageView/controllers/my_page_view_controller.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

class CustomBottomNavigation extends GetView<PageIndexController> {
  final myPageC = Get.find<MyPageViewController>();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () => myPageC.pageC.animateToPage(0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear),
                  minWidth: 40,
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: (controller.pageIndex.value == 0)
                              ? Icon(Ionicons.home,
                                  size: 22, color: primaryColor)
                              : const Icon(Ionicons.home_outline, size: 22),
                        ),
                        Text(
                          "Beranda",
                          style: (controller.pageIndex.value == 0)
                              ? TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: primaryColor,
                                )
                              : TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: AppColor.secondary,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 100),
              Expanded(
                child: MaterialButton(
                  onPressed: () => myPageC.pageC.animateToPage(1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear),
                  minWidth: 40,
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: (controller.pageIndex.value == 1)
                              ? Icon(Ionicons.person,
                                  size: 22, color: primaryColor)
                              : const Icon(Ionicons.person_outline, size: 22),
                        ),
                        Text(
                          "Profile",
                          style: (controller.pageIndex.value == 1)
                              ? TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: primaryColor,
                                )
                              : TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: AppColor.secondary,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
