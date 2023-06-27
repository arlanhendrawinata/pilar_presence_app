import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminMenuController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void test() async {
    print(await employeePresence());
  }

  Future<List<dynamic>> getData() async {
    final newData = [];
    final perizinan = ['overtime', 'sakit', 'cuti'];
    final QuerySnapshot<Map<String, dynamic>> queryDataUser =
        await firestore.collection("perizinan").get();
    final dataUser = await queryDataUser.docs.map((e) => e.data()).toList();
    // print("user: $dataUser");
    if (dataUser.length > 0) {
      for (var i = 0; i < dataUser.length; i++) {
        for (var j = 0; j < perizinan.length; j++) {
          final QuerySnapshot<Map<String, dynamic>> queryData = await firestore
              .collection("perizinan")
              .doc(dataUser[i]['uid'])
              .collection("${perizinan[j]}")
              .where("status", isEqualTo: "pending")
              .get();
          final data = queryData.docs.map((e) => e.data()).toList();
          // print(data);
          if (data.length > 0) {
            for (var k = 0; k < data.length; k++) {
              newData.add(data[k]);
            }
          }
        }
      }
    }
    return newData;
  }

  Future<int> employeePresence() async {
    String formattedCurrentDate =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    int countPresence = 0;
    final QuerySnapshot<Map<String, dynamic>> queryListUser =
        await firestore.collection("users").get();
    final listUser =
        await queryListUser.docs.map((e) => e.data()["uid"]).toList();
    if (listUser.length > 0) {
      for (var i = 0; i < listUser.length; i++) {
        final DocumentSnapshot<Map<String, dynamic>> queryPresence =
            await firestore
                .collection("users")
                .doc(listUser[i])
                .collection("presence")
                .doc(formattedCurrentDate)
                .get();
        if (queryPresence.exists) {
          countPresence += 1;
        }
      }
    }
    return countPresence;
  }

  Future<List<Map<String, dynamic>>> getActiveUser() async {
    final newData = [];
    final query = await firestore.collection("users").get();
    final data = query.docs
        .map((e) => e.data())
        .where((element) => element['status'] == "active")
        .toList();
    return data;
  }

  Future<AggregateQuerySnapshot> countAnnouncement() async {
    return await firestore.collection("pengumuman").count().get();
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

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
