import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/app/widgets/custom_textarea.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/announcement_add_controller.dart';

class AnnouncementAddView extends GetView<AnnouncementAddController> {
  const AnnouncementAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tambah Pengumuman',
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomInput(
                  controller: controller.title,
                  label: "Judul",
                  hint: "Judul",
                  context: context),
              const SizedBox(height: 20),
              CustomTextArea(
                  context: context,
                  controller: controller.body,
                  label: "Pesan",
                  hint: "Pesan"),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: Get.width,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.addAnnouncement();
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
                            'Tambah Pengumuman',
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
        ));
  }
}
