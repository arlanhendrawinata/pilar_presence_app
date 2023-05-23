import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OvertimeHistoryController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? start;
  DateTime end = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getPresence() async {
    String uid = await auth.currentUser!.uid;
    if (start == null) {
      // get all presence
      return await firestore
          .collection("users")
          .doc(uid)
          .collection("overtime")
          .where("date", isLessThan: end.toIso8601String())
          .orderBy('date', descending: true)
          .get();
    } else {
      // get from datepicker
      return await firestore
          .collection("users")
          .doc(uid)
          .collection("overtime")
          .where("date", isGreaterThan: start!.toIso8601String())
          .where("date",
              isLessThan: end.add(const Duration(days: 1)).toIso8601String())
          .orderBy('date')
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
    Get.back();
  }

  Future<void> onRefresh() async {
    start = null;
    end = DateTime.now();
    update();
  }
}
