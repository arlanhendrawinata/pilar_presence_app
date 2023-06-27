import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAnnouncement() async* {
    yield* firestore.collection("pengumuman").snapshots();
  }
}
