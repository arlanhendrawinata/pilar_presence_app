import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlong2/latlong.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
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
    double checkInlat = controller.data['checkIn']['lat'];
    double checkInlng = controller.data['checkIn']['lng'];

    // double checkInDistance = Geolocator.distanceBetween(
    //     -8.682509, 115.224580, checkInlat, checkInlng);

    double checkOutlat = controller.data['checkOut'] != null
        ? controller.data['checkOut']['lat']
        : controller.data['checkIn']['lat'];
    double checkOutlng = controller.data['checkOut'] != null
        ? controller.data['checkOut']['lng']
        : controller.data['checkIn']['lng'];

    // double checkOutDistance = Geolocator.distanceBetween(
    //     -8.682509,
    //     115.224580,
    //     controller.data['checkOut'] != null ? checkOutlat : checkInlat,
    //     controller.data['checkOut'] != null ? checkOutlng : checkInlng);

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
            onPressed: () => Get.offNamed(Routes.MONITORING),
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
        parallaxEnabled: true,
        parallaxOffset: 0.8,
        maxHeight: screenSize.height * 0.7,
        panel: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.15,
              width: Get.width,
              decoration:
                  BoxDecoration(color: softBlueColor, borderRadius: radius),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 3,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryExtraSoft,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Geser keatas untuk melihat peta lokasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.045,
                    width: screenSize.width,
                    child: Stack(
                      children: [
                        Positioned(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.tabs.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.current.value = index;
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 22),
                                child: Obx(() => Text(
                                      controller.tabs[index],
                                      style: TextStyle(
                                          color:
                                              controller.current.value == index
                                                  ? Colors.black87
                                                  : AppColor.secondarySoft,
                                          fontSize: Constant.textSize(
                                              context: context,
                                              fontSize:
                                                  controller.current.value ==
                                                          index
                                                      ? 16
                                                      : 15),
                                          fontWeight:
                                              controller.current.value == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => AnimatedPositioned(
                            bottom: 0,
                            left: controller.changePositionOfLine(),
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              height: 2,
                              width: 70,
                              decoration: BoxDecoration(color: dangerColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (controller.current.value != 1) {
                      return showDetailAbsen(
                          context, controller.data['checkIn']);
                    } else {
                      if (controller.data['checkOut'] != null) {
                        return showDetailAbsen(
                            context, controller.data['checkOut']);
                      } else {
                        return Center(
                          child: Text(
                            "User belum melakukan Absen Keluar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 14),
                            ),
                          ),
                        );
                      }
                    }
                  })
                ],
              ),
            ),
          ],
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
        body: Obx(
          () {
            if (controller.current.value != 1) {
              return map(checkInlat, checkInlng, "masuk");
            } else {
              if (controller.data['checkOut'] != null) {
                return map2(checkOutlat, checkOutlng, "keluar");
              }
              return map(checkInlat, checkInlng, "masuk");
            }
          },
        ),
        borderRadius: radius,
      ),
    );
  }

  Widget map(double lat, double lng, String type) {
    return FlutterMap(
      options: MapOptions(
          center: LatLng(lat, lng), zoom: 17.0, maxZoom: 18.3, minZoom: 13.0),
      children: [
        TileLayer(
          fastReplace: true,
          errorTileCallback: (tile, error) {
            CustomToast.dangerToast(
                "Terjadi Kesalahan", "$error", Get.context!);
          },
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
          keepBuffer: 2,
        ),
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: LatLng(lat, lng),
              builder: (context) => Icon(
                Ionicons.location,
                color: (type == "masuk") ? Colors.blue : Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget map2(double lat, double lng, String type) {
    return FlutterMap(
      key: const Key("map2"),
      options: MapOptions(
          center: LatLng(lat, lng), zoom: 17.0, maxZoom: 18.3, minZoom: 13.0),
      children: [
        TileLayer(
          fastReplace: true,
          errorTileCallback: (tile, error) {
            CustomToast.dangerToast(
                "Terjadi Kesalahan", "$error", Get.context!);
          },
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
          keepBuffer: 2,
        ),
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: LatLng(lat, lng),
              builder: (context) => Icon(
                Ionicons.location,
                color: (type == "masuk") ? Colors.blue : Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget showDetailAbsen(BuildContext context, Map<String, dynamic> data) {
    return Column(
      children: [
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
                          fontSize:
                              Constant.textSize(context: context, fontSize: 12),
                        ),
                      ),
                      Text(
                        "${data['address']}",
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
              bottom: BorderSide(width: 1, color: AppColor.secondaryExtraSoft),
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
                          fontSize:
                              Constant.textSize(context: context, fontSize: 12),
                        ),
                      ),
                      Text(
                        "${data['lat']}, ${data['lng']}",
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
                          fontSize:
                              Constant.textSize(context: context, fontSize: 12),
                        ),
                      ),
                      Text(
                        // "distance",
                        (data['distance'] >= 1000)
                            ? "${(data['distance'] / 1000).round()}km"
                            : "${data['distance'].round()}m",
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
                      Ionicons.locate_outline,
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
                        "Status Area",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize:
                              Constant.textSize(context: context, fontSize: 12),
                        ),
                      ),
                      Text(
                        "${data['status_area']}",
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
    );
  }
}
