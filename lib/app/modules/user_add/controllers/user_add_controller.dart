import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class UserAddController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController divisionC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  void addEmployee() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        divisionC.text.isNotEmpty) {
      Get.toNamed(Routes.ACCOUNT_VALIDATION, arguments: {
        "name": nameC.text,
        "email": emailC.text,
        "division": divisionC.text
      });
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom input tidak boleh kosong", Get.context!);
    }
  }

  Future<void> createEmployee() async {
    if (adminPassC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String emailAdmin = auth.currentUser!.email!;

        await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: adminPassC.text);

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "pilar123");

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          firestore.collection("users").doc(uid).set({
            "uid": uid,
            "name": nameC.text,
            "email": emailC.text,
            "role": "user",
            "status": "active",
            "created_at": DateTime.now().toIso8601String(),
          });

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: emailAdmin, password: adminPassC.text);

          Get.back(); // tutup dialog
          Get.back();
          CustomToast.successToast(
              "Berhasil", "User berhasil ditambahkan", Get.context!);
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password Anda terlalu lemah", Get.context!);
        } else if (e.code == 'email-already-in-use') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan",
              "Email telah terdaftar. Silahkan gunakan email lain",
              Get.context!);
        } else if (e.code == 'wrong-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password salah", Get.context!);
        } else {
          CustomToast.dangerToast("Terjadi Kesalahan", e.code, Get.context!);
        }
        isLoading.value = false;
      } catch (e) {
        CustomToast.dangerToast(
            "Terjadi Kesalahan", "Gagal menambahkan user baru", Get.context!);
        isLoading.value = false;
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Kolom imput tidak boleh kosong", Get.context!);
    }
  }
}
