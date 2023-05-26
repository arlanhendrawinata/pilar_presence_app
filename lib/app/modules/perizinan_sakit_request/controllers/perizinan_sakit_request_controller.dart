import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class PerizinanSakitRequestController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fstorage.FirebaseStorage storage = fstorage.FirebaseStorage.instance;

  Rx<File> image = File("").obs;
  XFile? photo;
  final ImagePicker picker = ImagePicker();

  RxBool isLoading = false.obs;

  TextEditingController ketSakitC = TextEditingController();

  requestSakit() async {
    bool isTodayReq = await isTodayRequest();
    print(isTodayReq);
    if (isTodayReq) {
      Get.back();
      CustomToast.dangerToast("Pengajuan Sakit",
          "Kamu telah mengajukan sakit hari ini", Get.context!);
    } else {
      addSakit();
    }
  }

  Future<bool> isTodayRequest() async {
    DateTime _currentDate = DateTime.now();
    String uid = await auth.currentUser!.uid;

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionPresence =
        await firestore.collection("perizinan").doc(uid).collection("sakit");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionPresence.doc(formattedCurrentDate).get();

    // Map<String, dynamic>? dataTodayDoc = todayDoc.data();

    if (todayDoc.exists) {
      return true;
    } else {
      return false;
    }
  }

  void pickImage() async {
    photo =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (photo != null) {
      // print(image.value.path);
      image.value = File(photo!.path);
      // print("image value: ${image.value.path}");
    } else {
      print("null");
    }
  }

  void addSakit() async {
    String uid = auth.currentUser!.uid;

    DateTime currentDate = DateTime.now();

    String formattedDatePresence =
        DateFormat.yMd().format(currentDate).replaceAll("/", "_");

    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");

    try {
      isLoading.value = true;
      String imgName = p.basename(image.value.path);
      String imgExt = imgName.split(".").last;
      // String imagePath = photo!.path;

      if (imgExt.toLowerCase() == "jpg" || imgExt == "png") {
        File fileImage = image.value;

        final newFileImage =
            await CompressAndGetFile(fileImage.path, imgName, imgExt, 50);

        CollectionReference<Map<String, dynamic>> collectionSakit =
            await firestore
                .collection("perizinan")
                .doc(uid)
                .collection("sakit");

        DocumentSnapshot<Map<String, dynamic>> userData =
            await firestore.collection("users").doc(uid).get();

        //* upload file to firebase storage
        await storage
            .ref("$uid/perizinan/sakit/$formattedDatePresence.$imgExt")
            .putFile(newFileImage);

        await collectionSakit.doc(formattedCurrentDate).set({
          "detail": ketSakitC.text,
          "date": currentDate.toIso8601String(),
          "status": "pending",
          "uid": uid,
          "name": userData.data()!['name'],
          "photoURL": await getImageURL(uid, formattedDatePresence, imgExt),
        });

        Get.back();
        CustomToast.successToast(
            "Pengajuan Sakit", "Pengajuan sakit berhasil", Get.context!);
      } else {
        CustomToast.dangerToast("Terjadi Kesalahan",
            "Silahkan upload gambar dengan extensi JPG/PNG", Get.context!);
      }
      isLoading.value = false;
    } catch (e) {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Pengajuan Sakit gagal", Get.context!);
      isLoading.value = false;
    }
  }

  Future<String> getImageURL(
      String uid, String formattedDatePresence, String imgExt) async {
    return await storage
        .ref("$uid/perizinan/sakit/$formattedDatePresence.$imgExt")
        .getDownloadURL();
  }

  Future<File> CompressAndGetFile(
      String path, String name, String ext, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path, "$name.$ext");
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }
}
