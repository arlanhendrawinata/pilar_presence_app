import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class PresenceRemoteController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fstorage.FirebaseStorage storage = fstorage.FirebaseStorage.instance;
  Rx<File> image = File("").obs;
  XFile? photo;
  final ImagePicker picker = ImagePicker();

  RxBool isLoading = false.obs;

  DateTime currentDate = DateTime.now();

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

  void uploadImage() async {
    // String uid = auth.currentUser!.uid;

    String formattedDatePresence =
        DateFormat.yMd().format(currentDate).replaceAll("/", "_");

    try {
      isLoading.value = true;
      String imgName = p.basename(image.value.path);
      String imgExt = imgName.split(".").last;
      // String imagePath = photo!.path;

      if (imgExt.toLowerCase() == "jpg" || imgExt == "png") {
        File fileImage = image.value;

        final newFileImage =
            await CompressAndGetFile(fileImage.path, imgName, imgExt, 50);

        //* upload file to firebase storage
        // await storage
        //     .ref("$uid/presence/$formattedDatePresence.$imgExt")
        //     .putFile(newFileImage);

        //* do presence
        await presence(formattedDatePresence, imgExt, newFileImage);
      } else {
        CustomToast.dangerToast("Terjadi Kesalahan",
            "Silahkan upload gambar dengan extensi JPG/PNG", Get.context!);
      }
      isLoading.value = false;
    } catch (e) {
      CustomToast.dangerToast("Terjadi Kesalahan", "Absen gagal", Get.context!);
      isLoading.value = false;
    }
  }

  Future<void> presence(
      String formattedDatePresence, String imgExt, File newFileImage) async {
    Map<String, dynamic> dataResponse = await determinePosition();
    if (dataResponse["error"] != true) {
      Position position = dataResponse["position"];
      isLoading.value = true;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String address =
          "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].subLocality}";
      double distance = Geolocator.distanceBetween(
          -8.682509, 115.224580, position.latitude, position.longitude);
      await addPresence(position, address, distance, formattedDatePresence,
          imgExt, newFileImage);
      isLoading.value = false;
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "${dataResponse['message']}", Get.context!);
    }
  }

  Future<String> getImageURL(String uid, String formattedDatePresence,
      String formattedCurrentDate, String imgExt, String presence) async {
    if (presence == "checkIn") {
      return await storage
          .ref(
              "$uid/presence/$formattedCurrentDate/checkIn/$formattedDatePresence.$imgExt")
          .getDownloadURL();
    } else {
      return await storage
          .ref(
              "$uid/presence/$formattedCurrentDate/checkOut/$formattedDatePresence.$imgExt")
          .getDownloadURL();
    }
  }

  Future<void> addPresence(Position position, String address, double distance,
      String formattedDatePresence, String imgExt, File newFileImage) async {
    String uid = await auth.currentUser!.uid;
    // print(newFileImage);

    CollectionReference<Map<String, dynamic>> collectionPresence =
        await firestore.collection("users").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapPresence =
        await collectionPresence.get();

    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");

    DateTime _currentDate = DateTime.now();
    DateTime _pilarDate = DateTime.parse("2018-08-16T08:00:00.000Z");
    final _pilarTime = double.parse(DateFormat('H.mm').format(_pilarDate));
    final _currentTime = double.parse(DateFormat('H.mm').format(_currentDate));
    String _presence_status = "ontime";
    if (_currentTime <= _pilarTime) {
      print('ontime');
      _presence_status = "ontime";
    } else {
      print('late');
      _presence_status = "late";
    }

    String statusArea = "Di luar area";

    try {
      //* distance 5m
      if (distance <= 5) {
        statusArea = "Di dalam area";
      }
      if (snapPresence.docs.length == 0) {
        //* collection presence is null
        await storage
            .ref(
                "$uid/presence/$formattedCurrentDate/checkIn/$formattedDatePresence.$imgExt")
            .putFile(newFileImage);

        await collectionPresence.doc(formattedCurrentDate).set({
          "status": "Dinas Luar",
          "date": _currentDate.toIso8601String(),
          "checkIn": {
            "photoURL": await getImageURL(uid, formattedDatePresence,
                    formattedCurrentDate, imgExt, "checkIn")
                .toString(),
            "date": _currentDate.toIso8601String(),
            "lat": position.latitude,
            "lng": position.longitude,
            "address": address,
            "distance": distance,
            "status_area": statusArea,
            "presence_status": _presence_status,
          },
        });
        Get.offAllNamed(Routes.MY_PAGE_VIEW);
        CustomToast.successToast(
            "Berhasil", "Absen masuk berhasil", Get.context!);
      } else {
        //* Collection presence is Exists
        DocumentSnapshot<Map<String, dynamic>> todayDoc =
            await collectionPresence.doc(formattedCurrentDate).get();

        if (todayDoc.exists) {
          //* Today Document is Exists. Update checkOut
          Map<String, dynamic>? dataTodayDoc = todayDoc.data();
          if (dataTodayDoc?["checkOut"] == null &&
              dataTodayDoc?["checkIn"] != null) {
            //* sudah absen masuk, tambah absen keluar
            await storage
                .ref(
                    "$uid/presence/$formattedCurrentDate/checkOut/$formattedDatePresence.$imgExt")
                .putFile(newFileImage);

            await collectionPresence.doc(formattedCurrentDate).update({
              "checkOut": {
                "photoURL": await getImageURL(uid, formattedDatePresence,
                    formattedCurrentDate, imgExt, "checkOut"),
                "date": _currentDate.toIso8601String(),
                "lat": position.latitude,
                "lng": position.longitude,
                "address": address,
                "distance": distance,
                "status_area": statusArea,
              },
            });
            Get.offAllNamed(Routes.MY_PAGE_VIEW);
            CustomToast.successToast(
                "Berhasil", "Absen keluar berhasil", Get.context!);
          } else {
            Get.offAllNamed(Routes.MY_PAGE_VIEW);
            CustomToast.infoToast(
                "Anda telah absen hari ini",
                "Silahkan melakukan absen kehadiran pada lain hari",
                Get.context!);
          }
        } else {
          //* today document is not Exists. Do CheckIn
          await storage
              .ref(
                  "$uid/presence/$formattedCurrentDate/checkIn/$formattedDatePresence.$imgExt")
              .putFile(newFileImage);

          await collectionPresence.doc(formattedCurrentDate).set({
            "status": "Dinas Luar",
            "date": _currentDate.toIso8601String(),
            "checkIn": {
              "photoURL": await getImageURL(uid, formattedDatePresence,
                  formattedCurrentDate, imgExt, "checkIn"),
              "date": _currentDate.toIso8601String(),
              "lat": position.latitude,
              "lng": position.longitude,
              "address": address,
              "distance": distance,
              "status_area": statusArea,
              "presence_status": _presence_status,
            },
          });
          Get.offAllNamed(Routes.MY_PAGE_VIEW);
          CustomToast.successToast(
              "Berhasil", "Absen masuk berhasil", Get.context!);
        }
      }
    } catch (e) {
      CustomToast.dangerToast("Terjadi Kesalahan", "$e", Get.context!);
      isLoading.value = false;
    }
  }

  void getPresenceData() async {
    String uid = await auth.currentUser!.uid;
    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");
    firestore
        .collection("users")
        .doc(uid)
        .collection("presence")
        .doc(formattedCurrentDate)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (data.isNotEmpty) {
          // print(data);
        } else {
          // print("empty");
        }
      },
      // onError: (e) => print("Error getting document: $e"),
    );
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

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message":
            "Layanan lokasi (GPS) dinonaktifkan. Silahkan mengaktifkan layanan lokasi Anda.",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message":
              "Izin lokasi ditolak. Silahkan memberikan izin lokasi pada aplikasi ini.",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin. Silahkan memberikan izin lokasi pada aplikasi ini.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {
      "position": position,
      "message": "Berhasil mendapatkan lokasi.",
      "error": false,
    };
  }
}
