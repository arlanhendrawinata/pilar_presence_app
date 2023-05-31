import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CutiTahunanController extends GetxController {
  int year = DateTime.now().year;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  DateTime selectedDate = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCutiTahunan() async* {
    yield* firestore.collection("cuti").snapshots();
  }

  pickYear() {}
}
