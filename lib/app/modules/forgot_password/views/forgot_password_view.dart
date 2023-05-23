import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScreenUtilInit(
          builder: (context, child) => Text(
            'Reset Password',
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
        builder: (context, child) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //image
                      Container(
                        height: 220.h,
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/forgot_password.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Masukkan email yang terkait dengan akun anda dan kami akan mengirimkan email dengan instruksi untuk mengatur ulang kata sandi anda",
                            style: TextStyle(
                              color: BlackSoftColor,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      CustomInput(
                        context: context,
                        controller: controller.emailC,
                        label: "Email",
                        hint: "youremail@gmail.com",
                        obsecureText: false,
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              if (controller.isLoading.isFalse) {
                                controller.resetPassword();
                              }
                            },
                            child: (controller.isLoading.isFalse)
                                ? Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 14),
                                    ),
                                  )
                                : Container(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              // padding: EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
