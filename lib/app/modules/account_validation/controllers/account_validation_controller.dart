import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class AccountValidationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController passC = TextEditingController();
  dynamic dataArgument = Get.arguments;

  RxBool isLoading = false.obs;

  Future<void> createEmployee() async {
    if (passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String emailAdmin = auth.currentUser!.email!;

        await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: passC.text);

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: dataArgument['email'], password: "pilar123");

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          firestore.collection("users").doc(uid).set({
            "uid": uid,
            "name": dataArgument['name'],
            "email": dataArgument['email'],
            "division": dataArgument['division'],
            "status": "active",
            "role": "user",
            "created_at": DateTime.now().toIso8601String(),
          });

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: emailAdmin, password: passC.text);
          Get.offAllNamed(Routes.USER_PROFILE);
          CustomToast.successToast(
              "Berhasil", "User berhasil ditambahkan", Get.context!);
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password Anda terlalu lemah", Get.context!);
        } else if (e.code == 'email-already-in-use') {
          Get.back();
          CustomToast.dangerToast(
              "Terjadi Kesalahan",
              "Email telah terdaftar. Silahkan gunakan email lain",
              Get.context!);
        } else if (e.code == 'wrong-password') {
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "Password salah", Get.context!);
        } else {
          Get.back();
          CustomToast.dangerToast(
              "Terjadi Kesalahan", "${e.code}", Get.context!);
        }
        isLoading.value = false;
      } catch (e) {
        Get.back();
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
