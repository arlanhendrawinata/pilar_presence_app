import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonitoringController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getEmployeeList() async {
    String formattedCurrentDate =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    final newData = [];
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
          final data = queryPresence.data();
          newData.add(data);
        }
      }
    }
    return newData;
  }

  Future<String> getUserData(String uid) async {
    final queryData = await firestore.collection("users").doc(uid).get();
    String data = await queryData.data()!['name'];
    return data;
  }

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
