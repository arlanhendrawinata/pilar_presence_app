import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PerizinanSakitController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> allDateSakit() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("perizinan")
        .doc(uid)
        .collection("sakit")
        .snapshots();
  }

  Future<AggregateQuerySnapshot> totalSakit() async {
    String uid = await auth.currentUser!.uid;
    return await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("sakit")
        .count()
        .get();
  }

  Future<void> sakitTahunan() async {
    String uid = await auth.currentUser!.uid;
    return await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("sakit")
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.data());
            }));
  }

  Future<AggregateQuerySnapshot> sakitStatus(String status) async {
    String uid = await auth.currentUser!.uid;
    return await firestore
        .collection("perizinan")
        .doc(uid)
        .collection("sakit")
        .where("status", isEqualTo: status)
        .count()
        .get();
  }
}
