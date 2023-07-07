import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

class OvertimeRequestController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController overtimeDetailC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  RxString timeStart = "00:00".obs;
  RxString timeEnd = "00:00".obs;
  // String? dateTimeStart;
  // String? dateTimeEnd;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  var dateFormat = DateFormat('yyyy-MM-dd');
  var timeFormat = DateFormat('Hm');

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void requestOvertime() async {
    DateTime date = selectedDate.value;
    date = DateTime(date.year, date.month, date.day, 23);
    if (dateC.text != "") {
      if (date.compareTo(DateTime.now()) > 0) {
        if (overtimeDetailC.text != "") {
          if (timeStart.value != "00:00") {
            if (timeEnd.value != "00:00") {
              try {
                await storeToUserOvertime();
              } catch (e) {
                CustomToast.dangerToast(
                    "Permintaan Lembur", "Error", Get.context!);
              }
            } else {
              CustomToast.dangerToast("Permintaan Lembur",
                  "Waktu selesai tidak boleh kosong!", Get.context!);
            }
          } else {
            CustomToast.dangerToast("Permintaan Lembur",
                "Waktu mulai tidak boleh kosong!", Get.context!);
          }
        } else {
          CustomToast.dangerToast("Permintaan Lembur",
              "Keterangan tidak boleh kosong!", Get.context!);
        }
      } else {
        CustomToast.dangerToast(
            "Permintaan Lembur",
            "Tidak diperbolehkan memilih tanggal sebelum tanggal saat ini",
            Get.context!);
      }
    } else {
      CustomToast.dangerToast(
          "Permintaan Lembur", "Tanggal tidak boleh kosong!", Get.context!);
    }
  }

  Future<void> storeToUserOvertime() async {
    DateTime date = selectedDate.value;
    date = DateTime(date.year, date.month, date.day, 23);
    // Timestamp dateTimeStamp = Timestamp.fromDate(date);
    String uid = await auth.currentUser!.uid;

    String formattedInputDate =
        DateFormat.yMd().format(date).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionOvertime =
        await firestore.collection("perizinan").doc(uid).collection("overtime");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionOvertime.doc(formattedInputDate).get();

    DocumentReference<Map<String, dynamic>> perizinanDoc =
        await firestore.collection("perizinan").doc(uid);

    DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection("users").doc(uid).get();

    String status = "pending";

    if (todayDoc.data() == null) {
      CustomAlertDialog.showDialog(
          context: Get.context!,
          title: "Apakah Anda yakin ingin mengirimkan permintaan 'Lembur' ?",
          message:
              "Silahkan konfirmasi terlebih dahulu sebelum melakukan permintaan 'Lembur'",
          isLoading: isLoading,
          onConfirm: () async {
            await perizinanDoc.set({
              "uid": uid,
            });

            await collectionOvertime.doc(formattedInputDate).set({
              "uid": uid,
              "detail": overtimeDetailC.text,
              "date": date.toIso8601String(),
              "time_start": timeStart.value,
              "time_end": timeEnd.value,
              "status": status,
              "name": userData.data()!['name'],
            });
            Get.back();
            Get.back();
            CustomToast.successToast("Berhasil",
                "Permintaan 'Lembur' berhasil dikirim", Get.context!);
          },
          onCancel: () => Get.back());
    } else {
      CustomToast.infoToast("Lembur", "Kamu telah mengirimkan ", Get.context!);
    }
  }

  Future<String> TodayOvertimeStatus() async {
    DateTime _currentDate = DateTime.now();
    String uid = await auth.currentUser!.uid;

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionOvertime =
        await firestore
            .collection("perizinan")
            .doc(formattedCurrentDate)
            .collection("lembur");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionOvertime.doc(uid).get();

    Map<String, dynamic>? dataTodayDoc = todayDoc.data();
    String overtimeStatus = dataTodayDoc!["status"];
    return overtimeStatus;
  }

  pickDate(context, DateTime initialDate, DateTime firstDate,
      DateTime lastDate) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickerDate != null) {
      selectedDate.value = pickerDate;
      dateC.text = DateFormat.yMd().format(pickerDate);
    }
  }

  getTime(context, RxString timeType) async {
    var pickedTime = await pickTime(context);
    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      // print(formattedTime);
      // DateTime convertedTime = DateFormat.jm().parse(formattedTime);
      // String time = DateFormat("HH:mm").format(convertedTime);
      timeType.value = formattedTime;
    } else {
      return 0;
    }
  }

  pickTime(context) async {
    DateTime date = DateTime.now();
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
    );
  }
}
