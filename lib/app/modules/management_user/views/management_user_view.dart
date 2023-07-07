import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:intl/intl.dart';
import '../controllers/management_user_controller.dart';

class ManagementUserView extends GetView<ManagementUserController> {
  const ManagementUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Manajemen Pengguna',
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
              size: 22,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: InkWell(
                onTap: () => Get.toNamed(Routes.USER_ADD),
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //* title
              SizedBox(
                height: Get.height * 0.045,
                width: Get.width,
                child: Stack(
                  children: [
                    Positioned(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.tabs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            controller.current.value = index;
                            controller.update();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 22),
                            child: Obx(() => Text(
                                  controller.tabs[index],
                                  style: TextStyle(
                                      color: controller.current.value == index
                                          ? Colors.black87
                                          : AppColor.secondarySoft,
                                      fontSize: Constant.textSize(
                                          context: context,
                                          fontSize:
                                              controller.current.value == index
                                                  ? 15
                                                  : 14),
                                      fontWeight:
                                          controller.current.value == index
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        bottom: 0,
                        left: controller.changePositionOfLine(),
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          height: 2,
                          width: 70,
                          decoration: BoxDecoration(color: dangerColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //* list users
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  child:
                      GetBuilder<ManagementUserController>(builder: (context) {
                    return FutureBuilder(
                        future: controller.getAllUser(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: AppColor.secondaryExtraSoft),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                                margin: index != snapshot.data!.length - 1
                                    ? const EdgeInsets.only(bottom: 10)
                                    : const EdgeInsets.only(bottom: 0),
                                child: ExpansionTile(
                                  shape:
                                      Border.all(width: 0, color: Colors.white),
                                  title: Text(
                                    "${snapshot.data![index]['name']}"
                                        .toCapitalCase(),
                                    style: TextStyle(
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14)),
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
                                            Row(
                                              children: [
                                                Text(
                                                  "Tanggal Bergabung: ",
                                                  style: TextStyle(
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat.yMMMEd().format(
                                                      DateTime.parse(
                                                          snapshot.data![index]
                                                              ['created_at'])),
                                                  style: TextStyle(
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 20),
                                                decoration: BoxDecoration(
                                                  color: AppColor.errorSoft,
                                                ),
                                                child: Text(
                                                  "Non active",
                                                  style: TextStyle(
                                                    color: AppColor.error,
                                                    fontSize: Constant.textSize(
                                                        context: context,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        });
                  }),
                ),
              ))
            ],
          ),
        ));
  }
}
