import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class UserUpdatePasswordController extends GetxController {
  TextEditingController oldPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  void updatePassword() async {
    if (oldPassC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        confirmPassC.text.isNotEmpty) {
      if (newPassC.text != "pilar123") {
        if (newPassC.text == confirmPassC.text) {
          try {
            isLoading.value = true;
            String emailUser = auth.currentUser!.email!;
            await auth.signInWithEmailAndPassword(
                email: emailUser, password: oldPassC.text);
            await auth.currentUser!.updatePassword(newPassC.text);
            Get.back(); // balik ke profile view
            CustomToast.successToast(
                "Berhasil", "Ubah password berhasil", Get.context!);
            isLoading.value = false;
          } on FirebaseAuthException catch (e) {
            if (e.code == "wrong-password") {
              CustomToast.dangerToast("Terjadi Kesalahan",
                  "Password yang anda masukkan salah", Get.context!);
            } else {
              CustomToast.dangerToast(
                  "Terjadi Kesalahan", "${e.code.toLowerCase()}", Get.context!);
            }
            isLoading.value = false;
          } catch (e) {
            CustomToast.dangerToast(
                "Terjadi Kesalahan", "Gagal ganti password", Get.context!);
            isLoading.value = false;
          }
        } else {
          CustomToast.dangerToast("Terjadi Kesalahan",
              "Konfirmasi password tidak cocok", Get.context!);
        }
      } else {
        CustomToast.dangerToast(
            "Terjadi Kesalahan",
            "Tidak boleh menggunakan password default. Silahkan ubah password baru anda",
            Get.context!);
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom input tidak boleh kosong", Get.context!);
    }
  }
}
