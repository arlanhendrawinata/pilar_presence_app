import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  Map<String, dynamic> data = Get.arguments;
  List<Placemark>? placemarks;
  // String? address;
  RxString address = "".obs;

  RxInt current = 0.obs;

  List<String> tabs = ["Absen Masuk", "Absen Keluar"];

  double changePositionOfLine() {
    switch (current.value) {
      case 0:
        return 0;
      case 1:
        return 122;
      default:
        return 0;
    }
  }

  Future<void> getAddress() async {
    final placemarks = await placemarkFromCoordinates(
        data['checkIn']['lat'], data['checkIn']['lng']);
    address.value =
        "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].subLocality}";
  }
}
