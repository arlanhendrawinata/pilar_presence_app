import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

class UserUpdateProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController birthPlaceC = TextEditingController();
  TextEditingController birthDateC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController goldarC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController kelurahanC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController agamaC = TextEditingController();
  TextEditingController status_kawinC = TextEditingController();
  TextEditingController pekerjaanC = TextEditingController();
  TextEditingController kewarganegaraanC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();

  RxString obsGender = "-".obs;
  RxString obsGoldar = "-".obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxBool isLoading = false.obs;

  final Map<String, dynamic> user = Get.arguments;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
    CustomAlertDialog.showDialogWithoutConfirm(
        title: "Ubah Data Diri",
        message:
            "Anda diharapkan untuk mengisi data diri sesuai dengan KTP Anda.",
        context: Get.context!,
        onCancel: () => Get.back());

    nameC.text = nameC.text.isEmpty ? user["name"] : "";

    birthPlaceC.text = user["profile"]?["birth_place"] != null
        ? user["profile"]["birth_place"]
        : "";
    birthDateC.text = user["profile"]?["birth_date"] != null
        ? user["profile"]["birth_date"]
        : "";
    genderC.text =
        user["profile"]?["gender"] != null ? user["profile"]["gender"] : "";
    obsGender.value =
        user["profile"]?["gender"] != null ? user["profile"]["gender"] : "";
    goldarC.text =
        user["profile"]?["goldar"] != null ? user["profile"]["goldar"] : "";
    obsGoldar.value =
        user["profile"]?["goldar"] != null ? user["profile"]["goldar"] : "";
    addressC.text =
        user["profile"]?["address"] != null ? user["profile"]["address"] : "";
    rtC.text = user["profile"]?["rt"] != null ? user["profile"]["rt"] : "";
    rwC.text = user["profile"]?["rw"] != null ? user["profile"]["rw"] : "";
    kelurahanC.text = user["profile"]?["kelurahan"] != null
        ? user["profile"]["kelurahan"]
        : "";
    kecamatanC.text = user["profile"]?["kecamatan"] != null
        ? user["profile"]["kecamatan"]
        : "";
    agamaC.text =
        user["profile"]?["agama"] != null ? user["profile"]["agama"] : "";
    status_kawinC.text = user["profile"]?["status_kawin"] != null
        ? user["profile"]["status_kawin"]
        : "";
    pekerjaanC.text = user["profile"]?["pekerjaan"] != null
        ? user["profile"]["pekerjaan"]
        : "";
    phoneNumberC.text =
        user['phone_number'] != null ? user["phone_number"] : "";
    kewarganegaraanC.text = "WNI";
  }

  void updateProfile() async {
    if (nameC.text.isNotEmpty &&
        birthDateC.text.isNotEmpty &&
        birthDateC.text.isNotEmpty &&
        birthPlaceC.text.isNotEmpty &&
        genderC.text.isNotEmpty &&
        goldarC.text.isNotEmpty &&
        addressC.text.isNotEmpty &&
        phoneNumberC.text.isNotEmpty &&
        rtC.text.isNotEmpty &&
        rwC.text.isNotEmpty &&
        kelurahanC.text.isNotEmpty &&
        kecamatanC.text.isNotEmpty &&
        agamaC.text.isNotEmpty &&
        status_kawinC.text.isNotEmpty &&
        pekerjaanC.text.isNotEmpty &&
        kewarganegaraanC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        await firestore.collection("users").doc(user["uid"]).update({
          "name": nameC.text,
          "phone_number": phoneNumberC.text,
          "profile": {
            "birth_place": birthPlaceC.text,
            "birth_date": birthDateC.text,
            "gender": genderC.text,
            "goldar": goldarC.text,
            "address": addressC.text,
            "rt": rtC.text,
            "rw": rwC.text,
            "kelurahan": kelurahanC.text,
            "kecamatan": kecamatanC.text,
            "agama": agamaC.text,
            "status_kawin": status_kawinC.text,
            "pekerjaan": pekerjaanC.text,
            "kewarganegaraan": kewarganegaraanC.text,
          }
        });
        Get.back();
        CustomToast.successToast(
            "Berhasil", "Update profile berhasil", Get.context!);
        isLoading.value = false;
      } catch (e) {
        CustomToast.dangerToast(
            "Terjadi Kesalahan", "Gagal update profile", Get.context!);
        isLoading.value = false;
      }
    } else {
      CustomToast.infoToast(
          "Ubah Data Diri",
          "Kolom inputan belum terisi semua. Silahkan mengisi terlebih dahulu.",
          Get.context!);
    }
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
      birthDateC.text = DateFormat('yyyy/MM/dd').format(pickerDate);
    }
  }
}
