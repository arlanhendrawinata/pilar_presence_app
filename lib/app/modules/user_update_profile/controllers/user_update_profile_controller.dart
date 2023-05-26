import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class UserUpdateProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  final Map<String, dynamic> user = Get.arguments;

  void updateProfile() async {
    try {
      isLoading.value = true;
      await firestore.collection("users").doc(user["uid"]).update({
        "name": nameC.text,
      });
      Get.back();
      CustomToast.successToast(
          "Berhasil", "Update profile berhasil", Get.context!);
      isLoading.value = false;
    } catch (e) {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Gagal update profile", Get.context!);
      isLoading.value = false;
    }
  }
}
