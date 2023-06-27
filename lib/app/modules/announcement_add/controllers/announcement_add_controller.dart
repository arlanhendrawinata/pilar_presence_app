import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class AnnouncementAddController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  RxBool isLoading = false.obs;

  addAnnouncement() async {
    String id = nanoid(10);
    try {
      isLoading.value = true;
      await firestore.collection("pengumuman").doc(id).set({
        "title": title.text,
        "body": body.text,
        "date": DateTime.now().toIso8601String(),
        "id": id,
      });
      isLoading.value = false;
      Get.back();
      CustomToast.successToast(
          "Pengumuman", "Berhasil menambahkan pengumuman.", Get.context!);
    } catch (e) {
      isLoading.value = false;
      CustomToast.dangerToast(
          "Pengumuman", "Gagal menambahkan pengumuman.", Get.context!);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
