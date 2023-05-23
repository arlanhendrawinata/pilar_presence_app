import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GeneralOvertimeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDocPresence() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("lembur")
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamOvertime() async* {
    String uid = await auth.currentUser!.uid;
    DateTime _currentDate = DateTime.now();
    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");
    yield* firestore
        .collection("perizinan")
        .doc(formattedCurrentDate)
        .collection("lembur")
        .doc(uid)
        .snapshots();
  }

  Future<bool> TodayOvertime() async {
    DateTime _currentDate = DateTime.now();
    String uid = await auth.currentUser!.uid;

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionOvertime =
        await firestore.collection("users").doc(uid).collection("overtime");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionOvertime.doc(formattedCurrentDate).get();

    if (todayDoc.data() == null) {
      return false;
    } else {
      return true;
    }
  }
}
