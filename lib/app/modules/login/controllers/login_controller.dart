import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController emailForgotPassC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isValidEmail = false;

  RxInt countTapped = 0.obs;
  RxInt duration = 0.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingSendEmail = false.obs;
  RxBool canResendEmail = true.obs;
  RxBool isLoadingForgotPassword = false.obs;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    regExp.hasMatch(em) ? isValidEmail = true : isValidEmail = false;

    return isValidEmail;
  }

  @override
  void onInit() {
    super.onInit();
    // print("tayo login");
  }

  forgotPassword() async {
    CustomAlertDialog.confirmation(
        context: Get.context!,
        title: "Reset Password",
        message:
            "Masukkan email yang terkait dengan akun anda dan kami akan mengirimkan email dengan instruksi untuk mengatur ulang kata sandi anda",
        label: "Email",
        hint: "youremail@gmail.com",
        isLoading: isLoading,
        obsecureText: true,
        onConfirmText: "Reset",
        onConfirm: () => sendResetPassword(),
        onCancel: () => Get.back(),
        controller: emailForgotPassC);
  }

  void sendResetPassword() async {
    if (emailC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.back(); // tutup dialog lupa password
        CustomToast.successToast(
            "Berhasil",
            "Kami telah mengirimkan reset password ke email anda. Silahkan cek email anda untuk melakukan ganti password",
            Get.context!);
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == "too-many-requests") {
          CustomToast.dangerToast(
              "Terjadi Kesalahan",
              "Terlalu banyak permintaan ganti password. Silahkan mencoba kembali atau hubungi admin.",
              Get.context!);
        }
        isLoading.value = false;
      } catch (e) {
        CustomToast.dangerToast(
            "Terjadi Kesalahan",
            "Tidak dapat mengirimkan email. Silahkan hubungi admin.",
            Get.context!);
        isLoading.value = false;
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom input tidak boleh kosong", Get.context!);
    }
  }

  void login() async {
    String email = emailC.text.trim();
    String password = passC.text.trim();

    // Field is not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // is email valid
      if (isEmail(email)) {
        try {
          isLoading.value = true;
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: email, password: password);

          // ketersediaan user
          if (userCredential.user != null) {
            // verifikasi email = true
            if (userCredential.user!.emailVerified == true) {
              if (password == "pilar123") {
                await CustomAlertDialog.showDialog(
                    context: Get.context!,
                    title: "Apakah Anda ingin mengganti password?",
                    message:
                        "Password akun Anda masih default. Kami menyarankan untuk mengganti password anda",
                    isLoading: isLoading,
                    onConfirm: () {
                      isLoading.value = false;
                      Get.back();
                      Get.toNamed(Routes.NEW_PASSWORD);
                    },
                    onCancel: () {
                      isLoading.value = false;
                      Get.offAllNamed(Routes.MY_PAGE_VIEW);
                    });
              } else {
                isLoading.value = false;
                Get.offAllNamed(Routes.MY_PAGE_VIEW);
              }
              // jika user belum verif email
            } else {
              CustomAlertDialog.showDialogWithTime(
                context: Get.context!,
                title: "Anda belum verifikasi email",
                canPressed: canResendEmail,
                countTapped: countTapped,
                message: "Silahkan melakukan verifikasi email terlebih dahulu",
                isLoading: isLoadingSendEmail,
                onConfirm: () async {
                  try {
                    countTapped + 1;
                    isLoadingSendEmail.value = true;
                    await userCredential.user!.sendEmailVerification();

                    Get.back(); // tutup dialog

                    CustomToast.successToast(
                        "Email Berhasil Dikirim",
                        "Kami telah mengirimkan verifikasil email.",
                        Get.context!);

                    isLoadingSendEmail.value = false;

                    if (countTapped == 1) {
                      // 1 menit
                      duration.value = 60;
                    } else if (countTapped == 2) {
                      // 5 menit
                      duration.value = 120;
                    } else if (countTapped == 3) {
                      // 10 menit
                      duration.value = 300;
                    } else if (countTapped == 4) {
                      // 20 menit
                      duration.value = 600;
                    } else {
                      // 1 hour
                      duration.value = 1200;
                      countTapped.value = 0;
                    }

                    canResendEmail.value = false;
                    await Future.delayed(Duration(seconds: duration.value));
                    canResendEmail.value = true;
                  } catch (e) {
                    CustomToast.dangerToast(
                        "Terjadi Kesalahan",
                        "Tidak dapat mengirim email verifikasi. Silahkan hubungi admin",
                        Get.context!);
                    isLoadingSendEmail.value = false;
                  }
                },
                onCancel: () {
                  isLoadingSendEmail.value = false;
                  Get.back();
                },
              );
            }
          }
          isLoading.value = false;
        } on FirebaseAuthException catch (e) {
          // print(e);
          if (e.code == 'user-not-found') {
            CustomToast.dangerToast(
                "Terjadi Kesalahan", "Email atau password salah", Get.context!);
          } else if (e.code == 'wrong-password') {
            CustomToast.dangerToast(
                "Terjadi Kesalahan", "Email atau password salah", Get.context!);
          } else if (e.code == 'too-many-requests') {
            CustomToast.dangerToast(
                "Terjadi Kesalahan",
                "Kami telah memblokir semua permintaan dari perangkat ini karena aktivitas yang tidak biasa. Silahkan coba lagi nanti.",
                Get.context!);
          }
          isLoading.value = false;
        } catch (e) {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Login gagal", Get.context!);
          isLoading.value = false;
        }
      } else {
        CustomToast.dangerToast(
            "Terjadi Kesalahan", "Email atau password salah", Get.context!);
        // isLoading.value = false;
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom input tidak boleh kosong", Get.context!);
      // isLoading.value = false;
    }
  }
}
