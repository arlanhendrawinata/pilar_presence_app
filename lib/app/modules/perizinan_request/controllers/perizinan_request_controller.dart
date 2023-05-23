import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilar_presence_app/app/modules/admin_menu/controllers/admin_menu_controller.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class PerizinanRequestController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  DateTime currentDate = DateTime.now();

  final adminMenuC = Get.find<AdminMenuController>();

  String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamOvertime() async* {
    // String formattedCurrentDate =
    //     DateFormat.yMd().format(currentDate).replaceAll("/", "-");

    yield* firestore
        .collection("perizinan")
        // .doc(formattedCurrentDate)
        // .collection(type)
        // .where("status", isEqualTo: "pending")
        .snapshots();
  }

  Future<List<dynamic>> getData(String type) async {
    final data2 = [];
    final QuerySnapshot<Map<String, dynamic>> queryDataUser =
        await firestore.collection("perizinan").get();
    final dataUser = queryDataUser.docs.map((e) => e.data()).toList();
    if (dataUser.length > 0) {
      for (var i = 0; i < dataUser.length; i++) {
        final QuerySnapshot<Map<String, dynamic>> queryData = await firestore
            .collection("perizinan")
            .doc(dataUser[i]['uid'])
            .collection(type)
            .where("status", isEqualTo: "pending")
            .get();
        final data = queryData.docs.map((e) => e.data()).toList();
        if (data.length > 0) {
          for (var j = 0; j < data.length; j++) {
            data2.add(data[j]);
          }
        }
      }
    }
    return data2;
  }

  void approvalPerizinan(
      String type, String status, String uid, String date) async {
    DateTime perizinanDate = DateTime.parse(date);
    isLoading = true.obs;
    String formattedCurrentDate =
        DateFormat.yMd().format(perizinanDate).replaceAll("/", "-");
    // print(formattedCurrentDate);
    if (status == "approve") {
      await approvePerizinan(type, formattedCurrentDate, uid);
    } else {
      await rejectPerizinan(type, formattedCurrentDate, uid);
    }
    isLoading = false.obs;
  }

  Future<void> approvePerizinan(
      String type, String formattedCurrentDate, String uid) async {
    String currentDate = DateTime.now().toIso8601String();
    CollectionReference<Map<String, dynamic>> collectionPerizinan =
        await firestore.collection("perizinan").doc(uid).collection(type);

    try {
      await collectionPerizinan
          .doc(formattedCurrentDate)
          .update({"status": "approved", "approved_at": currentDate});
      Get.back();
      CustomToast.successToast("Persetujuan Permintaan ${capitalize(type)}",
          "Berhasil melakukan persetujuan ${capitalize(type)}", Get.context!);
      update();
    } catch (e) {
      Get.back();
      CustomToast.dangerToast("Persetujuan Permintaan ${capitalize(type)}",
          "Gagal melakukan persetujuan ${capitalize(type)}!", Get.context!);
    }
  }

  Future<void> rejectPerizinan(
      String type, String formattedCurrentDate, String uid) async {
    String currentDate = DateTime.now().toIso8601String();
    CollectionReference<Map<String, dynamic>> collectionPerizinan =
        await firestore.collection("perizinan").doc(uid).collection(type);

    try {
      await collectionPerizinan
          .doc(formattedCurrentDate)
          .update({"status": "rejected", "rejected_at": currentDate});
      Get.back();
      CustomToast.successToast("Penolakan Permintaan ${capitalize(type)}",
          "Berhasil melakukan penolakan ${capitalize(type)}", Get.context!);
      update();
    } catch (e) {
      Get.back();
      CustomToast.dangerToast("Penolakan Permintaan ${capitalize(type)}",
          "Gagal melakukan penolakan ${capitalize(type)}!", Get.context!);
    }
  }
}
