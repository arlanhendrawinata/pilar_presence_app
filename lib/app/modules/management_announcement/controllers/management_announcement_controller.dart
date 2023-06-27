import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagementAnnouncementController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAnnouncement() async* {
    yield* firestore.collection("pengumuman").snapshots();
  }

  Map<String, dynamic> data = {};

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
