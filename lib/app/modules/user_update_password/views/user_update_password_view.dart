import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/user_update_password_controller.dart';

class UserUpdatePasswordView extends GetView<UserUpdatePasswordController> {
  const UserUpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ubah Password',
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 180,
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/forgot_password.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              CustomInput(
                  context: context,
                  controller: controller.oldPassC,
                  obsecureText: true,
                  label: "Password Lama",
                  hint: "************"),
              const SizedBox(
                height: 20,
              ),
              CustomInput(
                  context: context,
                  controller: controller.newPassC,
                  obsecureText: true,
                  label: "Password Baru",
                  hint: "************"),
              const SizedBox(
                height: 20,
              ),
              CustomInput(
                  context: context,
                  controller: controller.confirmPassC,
                  obsecureText: true,
                  label: "Konfirmasi Password",
                  hint: "************"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: Get.width,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.updatePassword();
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
                            'Ubah Password',
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
              )
            ],
          ),
        ));
  }
}
