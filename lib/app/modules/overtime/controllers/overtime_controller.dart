import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OvertimeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> allDatePerizinan() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("perizinan")
        .doc(uid)
        .collection("overtime")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPerizinanCount(
      String type) async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("perizinan")
        .doc(uid)
        .collection(type)
        .snapshots();
  }

  Future<void> Overtime() async {
    firestore
        .collection("perizinan")
        .get()
        .then((value) => print(value.docs.length));
  }

  Future<bool> TodayOvertime() async {
    DateTime _currentDate = DateTime.now();
    String uid = await auth.currentUser!.uid;

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionOvertime =
        await firestore.collection("perizinan").doc(uid).collection("overtime");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionOvertime.doc(formattedCurrentDate).get();

    if (todayDoc.data() == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<AggregateQuerySnapshot> overtimeStatus(String status) async {
    String uid = await auth.currentUser!.uid;
    return await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("overtime")
        .where("status", isEqualTo: status)
        .count()
        .get();
  }
}
