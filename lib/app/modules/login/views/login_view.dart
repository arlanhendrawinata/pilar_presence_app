import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_input.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: ScreenUtilInit(
          designSize: ScreenUtil.defaultSize,
          minTextAdapt: true,
          builder: (context, child) {
            return Stack(
              children: [
                //background
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/gradient_line.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.only(left: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilar Kreatif Teknologi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 24),
                              ),
                            ),
                            // SizedBox(height: 6),
                            Text(
                              'Presence App',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.55,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Masuk ke akun Anda",
                                style: TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          buildEmail(context),
                          SizedBox(height: 16.h),
                          buildPassword(context),
                          TextButton(
                            onPressed: () =>
                                Get.toNamed(Routes.FORGOT_PASSWORD),
                            child: Text(
                              "Lupa Password?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          buildLoginBtn(context),
                        ],
                      ),
                    )
                  ],
                ),
                // pilar

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: SingleChildScrollView(
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //           vertical: 20.h, horizontal: 20.h),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(30.r),
                //           topRight: Radius.circular(30.r),
                //         ),
                //       ),
                //       height: screenHeight * 0.6,
                //       child: Column(
                //         // crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Expanded(
                //             child: Container(
                //               alignment: Alignment.center,
                //               child: Text(
                //                 "Masuk ke akun Anda",
                //                 style: TextStyle(
                //                   fontSize: Constant.textSize(
                //                       context: context, fontSize: 16),
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             child: buildEmail(context),
                //           ),
                //           SizedBox(height: 20.h),
                //           buildPassword(context),
                //           Align(
                //             alignment: Alignment.centerRight,
                //             child: TextButton(
                //               onPressed: () =>
                //                   Get.toNamed(Routes.FORGOT_PASSWORD),
                //               child: Text(
                //                 "Lupa Password?",
                //                 textAlign: TextAlign.end,
                //                 style: TextStyle(
                //                   color: primaryColor,
                //                   fontSize: Constant.textSize(
                //                       context: context, fontSize: 14),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(height: 20.h),
                //           buildLoginBtn(context),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return CustomInput(
        context: context,
        controller: controller.emailC,
        label: "Email",
        hint: "youremail@gmail.com");
  }

  Widget buildPassword(BuildContext context) {
    return CustomInput(
      context: context,
      controller: controller.passC,
      label: "Password",
      hint: "************",
      obsecureText: true,
    );
  }

  Widget buildLoginBtn(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: MediaQuery.of(context).size.width,
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            if (controller.isLoading.isFalse) {
              controller.login();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            // padding: EdgeInsets.symmetric(vertical: 18),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: (controller.isLoading.isFalse)
              ? Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                )
              : SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
