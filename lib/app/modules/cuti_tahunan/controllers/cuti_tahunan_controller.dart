import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:get/get.dart';

class CutiTahunanController extends GetxController {
  int year = DateTime.now().year;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController amountCuti = TextEditingController();

  RxBool isLoading = false.obs;
  DateTime selectedDate = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCutiTahunan() async* {
    yield* firestore.collection("cuti").snapshots();
  }

  Future<void> addCutiTahunan() async {
    try {
      await firestore.collection("cuti").doc("${selectedDate.year}").set({
        "amount": amountCuti.text,
        "year": selectedDate.year,
      });
      Get.back();
      CustomToast.successToast("Cuti Tahunan",
          "Berhasil menambahkan data cuti tahunan.", Get.context!);
    } catch (e) {
      Get.back();
      CustomToast.dangerToast("Terjadi Kesalahan", "$e", Get.context!);
    }
  }
}
