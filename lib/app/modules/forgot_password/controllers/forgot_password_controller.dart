import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  void resetPassword() async {
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
}
