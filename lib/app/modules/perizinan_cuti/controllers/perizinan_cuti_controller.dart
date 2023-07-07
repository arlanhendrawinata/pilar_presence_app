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

  int daysBetween2(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> cutiTahunan() async {
    int year = DateTime.now().year;
    return await firestore.collection("cuti").doc("$year").get();
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
                // int dtStart = int.parse(DateFormat.d()
                //     .format());
                // int dtEnd = int.parse(DateFormat.d()
                //     .format(DateTime.parse(element.data()['cuti_end'])));
                dateminus += daysBetween2(
                        DateTime.parse(element.data()['cuti_start']),
                        DateTime.parse(element.data()['cuti_end'])) +
                    1;
              }
            }));
    return dateminus;
  }

  Future<int> sisaCuti() async {
    // int totalCuti = 12;
    Future<bool> tahunan = cutiTahunan().then((value) => value.exists);
    if (await tahunan) {
      DocumentSnapshot<Map<String, dynamic>> cutiTahunan = await firestore
          .collection("cuti")
          .doc("${DateTime.now().year}")
          .get();
      Map<String, dynamic>? data = cutiTahunan.data();
      // Future<dynamic> amountCuti =
      //     cutiTahunan().then((value) => value.data()!['amount']);
      // totalCuti = int.parse(await amountCuti);
      int dateminus = await getCuti();
      return int.parse(data!['amount']) - dateminus;
    } else {
      return 0;
    }
  }
}
