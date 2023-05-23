import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerizinanCutiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> allDatePerizinan() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("perizinan")
        .doc(uid)
        .collection("cuti")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCount(String type) async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("perizinan")
        .doc(uid)
        .collection(type)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> cutiTahunan() async {
    int year = DateTime.now().year;
    return await firestore.collection("cuti").doc("${year}").get();
  }

  Future<AggregateQuerySnapshot> cutiStatus(String status) async {
    String uid = await auth.currentUser!.uid;
    return await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("cuti")
        .where("status", isEqualTo: status)
        .count()
        .get();
  }

  Future<int> getCuti() async {
    String uid = await auth.currentUser!.uid;
    int dateminus = 0;

    // get all presence
    await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("cuti")
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.data()['status'] == 'approved') {
                int dtStart = int.parse(DateFormat.d()
                    .format(DateTime.parse(element.data()['cuti_start'])));
                int dtEnd = int.parse(DateFormat.d()
                    .format(DateTime.parse(element.data()['cuti_end'])));
                dateminus += (dtEnd - dtStart) + 1;
              }
            }));
    return dateminus;
  }

  Future<int> sisaCuti() async {
    int totalCuti = 12;
    int dateminus = await getCuti();
    return totalCuti - dateminus;
  }

  // Future<Map<String, dynamic>> tes() {
  //   Map<String, dynamic> halo = {'name': 'arlan'};
  //   return halo;
  // }
}
