import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminMenuController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void test() async {
    await getData();
  }

  Future<List<dynamic>> getData() async {
    final newData = [];
    final perizinan = ['overtime', 'sakit', 'cuti'];
    final QuerySnapshot<Map<String, dynamic>> queryDataUser =
        await firestore.collection("perizinan").get();
    final dataUser = await queryDataUser.docs.map((e) => e.data()).toList();
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
          print(data);
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
