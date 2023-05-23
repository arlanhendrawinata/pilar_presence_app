import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';

class UserProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fstorage.FirebaseStorage storage = fstorage.FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  String? docPhotoUrl;
  RxBool isLoading = false.obs;

  final pageC = Get.find<PageIndexController>();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore.collection("users").doc(uid).snapshots();
  }

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    String uid = auth.currentUser!.uid;

    try {
      if (image != null) {
        String imgExt = image!.name.split(".").last;
        // String imgName = image!.name;
        String imagePath = image!.path;

        if (imgExt.toLowerCase() == "jpg" || imgExt == "png") {
          File file = File(imagePath);

          await storage.ref("$uid/photoProfile.$imgExt").putFile(file);

          String urlImage =
              await storage.ref("$uid/photoProfile.$imgExt").getDownloadURL();
          await firestore
              .collection("users")
              .doc(uid)
              .update({"photoURL": urlImage});
          // }
          CustomToast.successToast(
              "Berhasil", "Ganti foto profil berhasil", Get.context!);
        } else {
          CustomToast.dangerToast("Terjadi Kesalahan",
              "Silahkan upload gambar dengan extensi JPG/PNG", Get.context!);
        }
      }
    } catch (e) {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "Gagal ganti foto profil", Get.context!);
    }
  }

  void logout(RxBool isLoading) async {
    CustomAlertDialog.showDialog(
      title: "Apakah Anda yakin ingin logout?",
      message: "Silahkan konfirmasi terlebih dahulu untuk melakukan logout",
      isLoading: isLoading,
      context: Get.context!,
      onConfirm: () async {
        isLoading.value = true;
        await auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
        isLoading.value = false;
        pageC.pageIndex.value = 0;
      },
      onCancel: () => Get.back(),
    );
  }
}
