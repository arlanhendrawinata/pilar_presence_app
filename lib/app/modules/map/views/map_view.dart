import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/app/widgets/custom_toast.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/map_controller.dart' as myMap;

class MapView extends GetView<myMap.MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    Size screenSize = MediaQuery.of(context).size;
    double lat = controller.position.latitude;
    double lng = controller.position.longitude;

    double distance =
        Geolocator.distanceBetween(-8.682509, 115.224580, lat, lng);

    controller.getAddress();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Peta Lokasi',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: ScreenUtilInit(
          builder: (context, child) => IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Ionicons.arrow_back,
              color: Colors.black87,
              size: 22.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: SlidingUpPanel(
        maxHeight: screenSize.height * 0.5,
        panel: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColor.secondaryExtraSoft,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: screenSize.width,
                child: Text(
                  "Detail Lokasi",
                  style: TextStyle(
                      fontSize:
                          Constant.textSize(context: context, fontSize: 16),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: AppColor.secondaryExtraSoft))),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        color: secondaryColor,
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Ionicons.pin_outline,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat",
                              style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                              ),
                            ),
                            Obx(
                              () => Text(
                                "${controller.address}",
                                style: TextStyle(
                                    color: AppColor.secondary,
                                    fontSize: Constant.textSize(
                                        context: context, fontSize: 12),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                          color: secondaryColor,
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Ionicons.location_outline,
                            color: primaryColor,
                            size: 24,
                          )),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LatLng",
                              style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                              ),
                            ),
                            Text(
                              "$lat, $lng",
                              style: TextStyle(
                                  color: AppColor.secondary,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: AppColor.secondaryExtraSoft))),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                          color: secondaryColor,
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Ionicons.navigate_outline,
                            color: primaryColor,
                            size: 24,
                          )),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jarak",
                              style: TextStyle(
                                color: AppColor.secondarySoft,
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                              ),
                            ),
                            Text(
                              (distance >= 1000)
                                  ? "${(distance / 1000).round()}km"
                                  : "${distance.round()}m",
                              style: TextStyle(
                                  color: AppColor.secondary,
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 14),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        collapsed: Container(
          decoration: BoxDecoration(color: softBlueColor, borderRadius: radius),
          child: Center(
            child: Text(
              "Geser keatas untuk melihat detail lokasi",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Constant.textSize(context: context, fontSize: 14),
              ),
            ),
          ),
        ),
        body: FlutterMap(
          options: MapOptions(
              center: LatLng(lat, lng),
              zoom: 17.0,
              maxZoom: 18.3,
              minZoom: 13.0),
          children: [
            TileLayer(
              errorTileCallback: (tile, error) {
                CustomToast.dangerToast(
                    "Terjadi Kesalahan", "$error", Get.context!);
              },
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              keepBuffer: 4,
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, lng),
                  builder: (context) => const Icon(
                    Ionicons.location,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ],
        ),
        borderRadius: radius,
      ),
    );
  }
}
