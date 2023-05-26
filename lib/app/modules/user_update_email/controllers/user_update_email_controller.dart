import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class UserUpdateEmailController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController userPassC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final pageC = Get.find<PageIndexController>();

  void updateEmail() async {
    if (emailC.text.isNotEmpty) {
      CustomAlertDialog.confirmation(
        context: Get.context!,
        title: "Validasi Akun",
        message:
            "Silahkan validasi akun anda sebelum melakukan perubahan alamat email",
        label: "Password",
        hint: "************",
        isLoading: isLoading,
        obsecureText: true,
        onConfirm: () {
          if (isLoading.isFalse) {
            processUpdate();
          }
        },
        onCancel: () {
          Get.back();
          userPassC.clear();
          isLoading.value = false;
        },
        onConfirmText: "validasi",
        controller: userPassC,
      );
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom input tidak boleh kosong", Get.context!);
    }
  }

  Future<void> processUpdate() async {
    if (userPassC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String emailAdmin = auth.currentUser!.email!;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: userPassC.text);
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          firestore.collection("users").doc(uid).update({
            "email": emailC.text,
          });

          await auth.currentUser!.updateEmail(emailC.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: emailC.text, password: userPassC.text);
          await auth.currentUser!.sendEmailVerification();

          // tutup dialog verifikasi akun
          await auth.signOut();
          pageC.pageIndex.value = 0;
          Get.offAllNamed(Routes.LOGIN);
          CustomToast.successToast(
              "Berhasil",
              "Ganti email berhasil. Silahkan cek email anda untuk melakukan verifikasi",
              Get.context!);
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password Anda terlalu lemah", Get.context!);
        } else if (e.code == 'email-already-in-use') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan",
              "Email sudah terdaftar. Silahkan menggunakan email lain",
              Get.context!);
        } else if (e.code == 'wrong-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password salah", Get.context!);
        } else {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "${e.code}", Get.context!);
        }
        isLoading.value = false;
      } catch (e) {
        CustomToast.dangerToast(
            "Terjadi Kesalahan", "Ganti email gagal", Get.context!);
        isLoading.value = false;
      }
    }
  }
}
