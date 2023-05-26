import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class PerizinanCutiRequestController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController ketCutiC = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isLoading = false.obs;

  DateTime? dateStart;
  DateTime? dateEnd;

  RxString defDateStart = ''.obs;

  RxString defDateEnd = ''.obs;

  Future<DocumentSnapshot<Map<String, dynamic>>> cutiTahunan() async {
    int year = DateTime.now().year;
    return await firestore.collection("cuti").doc("$year").get();
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
              if (element.data()['status'] != 'rejected') {
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
    int totalCuti =
        await cutiTahunan().then((value) => value.data()!['amount']);
    int dateminus = await getCuti();
    return totalCuti - dateminus;
  }

  requestCuti() async {
    if (dateStart != null && dateEnd != null && ketCutiC.text != "") {
      if (dateStart!.compareTo(dateEnd!) < 0) {
        int countDateRequest = (dateEnd!.day - dateStart!.day) + 1;
        int _sisaCuti = await sisaCuti().then((value) => value);
        if (_sisaCuti - countDateRequest >= 0) {
          await addCuti();
        } else {
          CustomToast.dangerToast(
              "Pengajuan Cuti",
              "Tanggal tidak boleh melebihi sisa cuti. Silahkan memperhatikan sisa cuti anda.",
              Get.context!);
        }
      } else {
        CustomToast.dangerToast(
            "Pengajuan Cuti",
            "Tanggal mulai tidak boleh melebihi tanggal selesai.",
            Get.context!);
      }
    } else {
      CustomToast.dangerToast("Pengajuan Cuti",
          "Silahkan mengisi semua kolom inputan pengajuan cuti.", Get.context!);
    }
  }

  Future<void> addCuti() async {
    String uid = auth.currentUser!.uid;
    DateTime currentDate = DateTime.now();
    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");

    try {
      CollectionReference<Map<String, dynamic>> collectionCuti =
          firestore.collection("perizinan").doc(uid).collection("cuti");

      DocumentSnapshot<Map<String, dynamic>> userData =
          await firestore.collection("users").doc(uid).get();

      await collectionCuti.doc(formattedCurrentDate).set({
        "detail": ketCutiC.text,
        "date": currentDate.toIso8601String(),
        "cuti_start": dateStart!.toIso8601String(),
        "cuti_end": dateEnd!.toIso8601String(),
        "status": "pending",
        "uid": uid,
        "name": userData.data()!['name'],
      });

      Get.toNamed(Routes.PERIZINAN_CUTI);
      CustomToast.successToast(
          "Pengajuan Cuti", "Pengajuan cuti berhasil", Get.context!);
    } catch (e) {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Pengajuan cuti gagal", Get.context!);
    }
  }

  pickStartDate(BuildContext context) async {
    DateTime now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 3);
    DateTime lastday = DateTime(now.year, now.month + 1, 0);
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastday,
    );

    if (pickerDate != null) {
      dateStart =
          DateTime(pickerDate.year, pickerDate.month, pickerDate.day, 23);
      defDateStart.value =
          DateFormat.yMd().format(dateStart!).replaceAll("/", "-");
    }
  }

  pickEndDate(BuildContext context) async {
    DateTime now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 3);
    DateTime lastday = DateTime(now.year, now.month + 1, 0);
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastday,
    );

    if (pickerDate != null) {
      dateEnd = DateTime(pickerDate.year, pickerDate.month, pickerDate.day, 23);
      defDateEnd.value = DateFormat.yMd().format(dateEnd!).replaceAll("/", "-");
    }
  }
}
