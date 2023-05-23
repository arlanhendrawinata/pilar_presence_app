import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/widgets/custom_alert_dialog.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:intl/intl.dart';

class PresenceController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime currentDate = DateTime.now();
  RxBool isLoading = false.obs;
  RxBool isLoadingRemote = false.obs;
  Map<String, dynamic>? todayPresenceExist;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPresence() async* {
    String uid = await auth.currentUser!.uid;
    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("presence")
        .doc(formattedCurrentDate)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDocPresence() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("presence")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLast5daysPresence() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("presence")
        .orderBy("date")
        .limitToLast(5)
        .snapshots();
  }

  Future<void> todayPresence() async {
    String uid = await auth.currentUser!.uid;
    String formattedCurrentDate =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");
    await firestore
        .collection("users")
        .doc(uid)
        .collection("presence")
        .doc(formattedCurrentDate)
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>?;
      todayPresenceExist = data?['checkOut'];
    });

    // .then((value) {
    // print(value.data()?['checkOut']?.length);
    // todayPresenceExist = "${value.data()?['checkOut']}";
    // if (value.data()?.length != null) {
    //   print("data: ${value.data()?.length}");
    //   todayPresenceExist = "${value.data()?.length}";
    // } else {
    //   todayPresenceExist = "${value.data()?.length}";
    //   print("data: ${value.data()?.length}");
    // }
    // });
  }

  Future<bool> isTodayPresence() async {
    DateTime _currentDate = DateTime.now();
    String uid = await auth.currentUser!.uid;

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> collectionPresence =
        await firestore.collection("users").doc(uid).collection("presence");

    DocumentSnapshot<Map<String, dynamic>> todayDoc =
        await collectionPresence.doc(formattedCurrentDate).get();

    Map<String, dynamic>? dataTodayDoc = todayDoc.data();

    if (todayDoc.exists) {
      print('todayDoc : ${todayDoc.exists}');
      if (dataTodayDoc?["checkOut"] == null &&
          dataTodayDoc?["checkIn"] != null) {
        print('checkout : ${todayDoc.exists}');
        return false;
      } else {
        print('ispresence : ${todayDoc.exists}');
        return true;
      }
    } else {
      return false;
    }
  }

  Future<void> presence() async {
    Map<String, dynamic> dataResponse = await determinePosition();
    if (dataResponse["error"] != true) {
      try {
        isLoading.value = true;
        Position position = dataResponse["position"];
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        String address =
            "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].subLocality}";
        double distance = Geolocator.distanceBetween(
            -8.6825542, 115.2246695, position.latitude, position.longitude);
        await addPresence(position, address, distance);
        isLoading.value = false;
      } on PlatformException catch (e) {
        if (e.code == "IO_ERROR") {
          CustomToast.dangerToast(
              "Network Error",
              "Silahkan cek network Anda untuk melakukan absen kehadiran",
              Get.context!);
        }
      } catch (e) {
        CustomToast.dangerToast(
            "Terjadi Kesalahan", "Absen kehadiran gagal", Get.context!);
        print(e);
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan", "${dataResponse['message']}", Get.context!);
    }
  }

  Future<void> addPresence(
      Position position, String address, double distance) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> collectionPresence =
        await firestore.collection("users").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapPresence =
        await collectionPresence.get();

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

    String formattedCurrentDate =
        DateFormat.yMd().format(_currentDate).replaceAll("/", "-");

    String statusArea = "Di luar area";

    if (distance != 5) {
      // if (distance <= 5) {
      statusArea = "Di dalam area";

      if (snapPresence.docs.length == 0) {
        // jika doc pada collection presence kosong / null
        Get.back();
        CustomAlertDialog.showDialog(
            context: Get.context!,
            title: "Apakah Anda yakin ingin melakukan absen hadir 'Masuk' ?",
            message:
                "Silahkan konfirmasi terlebih dahulu sebelum melakukan absen kehadiran",
            isLoading: isLoading,
            onConfirm: () async {
              await collectionPresence.doc(formattedCurrentDate).set({
                "status": "Kantor",
                "date": _currentDate.toIso8601String(),
                "checkIn": {
                  "date": _currentDate.toIso8601String(),
                  "lat": position.latitude,
                  "lng": position.longitude,
                  "address": address,
                  "distance": distance,
                  "status_area": statusArea,
                  "presence_status": _presence_status,
                },
              });
              Get.back();
              CustomToast.successToast(
                  "Berhasil", "Absen hadir 'Masuk' berhasil", Get.context!);
            },
            onCancel: () => Get.back());
      } else {
        // jika ada doc pada collection presence / != null
        DocumentSnapshot<Map<String, dynamic>> todayDoc =
            await collectionPresence.doc(formattedCurrentDate).get();

        if (todayDoc.exists) {
          //jika true, update absen keluar
          Map<String, dynamic>? dataTodayDoc = todayDoc.data();
          if (dataTodayDoc?["checkOut"] == null &&
              dataTodayDoc?["checkIn"] != null) {
            // sudah absen masuk, tambah absen keluar
            Get.back();
            CustomAlertDialog.showDialog(
                context: Get.context!,
                title: "Apakah Anda yakin ingin melakukan absen 'Keluar' ?",
                message:
                    "Silahkan konfirmasi terlebih dahulu sebelum melakukan absen kehadiran",
                isLoading: isLoading,
                onConfirm: () async {
                  await collectionPresence.doc(formattedCurrentDate).update({
                    "checkOut": {
                      "date": _currentDate.toIso8601String(),
                      "lat": position.latitude,
                      "lng": position.longitude,
                      "address": address,
                      "distance": distance,
                      "status_area": statusArea,
                    },
                  });
                  Get.back();
                  CustomToast.successToast(
                      "Berhasil", "Absen keluar berhasil", Get.context!);
                },
                onCancel: () => Get.back());
          } else {
            Get.back();
            CustomToast.infoToast(
                "Anda telah absen hari ini",
                "Silahkan melakukan absen kehadiran pada lain hari",
                Get.context!);
          }
        } else {
          // jika false, set absen masuk baru
          Get.back();
          CustomAlertDialog.showDialog(
              context: Get.context!,
              title: "Apakah Anda yakin ingin melakukan absen hadir 'Masuk' ?",
              message:
                  "Silahkan konfirmasi terlebih dahulu sebelum melakukan absen kehadiran",
              isLoading: isLoading,
              onConfirm: () async {
                await collectionPresence.doc(formattedCurrentDate).set({
                  "status": "Kantor",
                  "date": _currentDate.toIso8601String(),
                  "checkIn": {
                    "date": _currentDate.toIso8601String(),
                    "lat": position.latitude,
                    "lng": position.longitude,
                    "address": address,
                    "distance": distance,
                    "status_area": statusArea,
                    "presence_status": _presence_status,
                  },
                });
                Get.back();
                CustomToast.successToast(
                    "Berhasil", "Absen hadir 'Masuk' berhasil", Get.context!);
              },
              onCancel: () => Get.back());
        }
      }
    } else {
      CustomToast.dangerToast(
          "Terjadi Kesalahan",
          "Anda absen diluar kantor. Silahkan absen di area kantor",
          Get.context!);
    }
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
