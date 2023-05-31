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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
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
                child: Column(
                  children: [
                    Expanded(
                      flex: isPortrait ? 2 : 3,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        width: Get.width,
                        // height: Get.height * 0.45,
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: isPortrait ? 2 : 4,
                      child: Container(
                        width: Get.width,
                        // height: Get.height * 0.55,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
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
                                        context: context, fontSize: 14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            buildEmail(context),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            buildLoginBtn(context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
      height: 50,
      width: Get.width,
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
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: (controller.isLoading.isFalse)
              ? Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: Constant.textSize(context: context, fontSize: 14),
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
    );
  }
}
