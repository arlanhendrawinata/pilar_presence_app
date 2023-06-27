import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/user_add_controller.dart';

class UserAddView extends GetView<UserAddController> {
  const UserAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Karyawan',
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
            width: MediaQuery.of(context).size.width,
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
              CustomInput(
                  context: context,
                  controller: controller.nameC,
                  label: "Nama",
                  hint: "John Doe"),
              const SizedBox(height: 20),
              CustomInput(
                  context: context,
                  controller: controller.emailC,
                  label: "Email",
                  hint: "youremail@gmail.com"),
              const SizedBox(height: 20),
              CustomInput(
                  context: context,
                  controller: controller.divisionC,
                  label: "Divisi",
                  hint: "-"),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.addEmployee();
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
                            'Tembah Karyawan',
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
