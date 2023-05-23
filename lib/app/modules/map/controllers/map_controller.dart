import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  Position position = Get.arguments;
  List<Placemark>? placemarks;
  // String? address;
  RxString address = "".obs;

  Future<void> getAddress() async {
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    address.value =
        "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].subLocality}";
  }
}
