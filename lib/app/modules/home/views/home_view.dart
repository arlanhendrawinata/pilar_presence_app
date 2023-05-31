import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:deep_collection/deep_collection.dart';
import '../controllers/home_controller.dart';
import '../../../../constant.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data?.data();
            String profileName = controller.capitalize(user?["name"]);
            String imageUrl = "https://ui-avatars.com/api/?name=$profileName";
            String photoURL = user?["photoURL"] ?? imageUrl;

            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    //* TODAY PRESENCE STREAM
                    stream: controller.presenceC.streamPresence(),
                    builder: (context, snapshotPresence) {
                      if (snapshotPresence.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: context.mediaQueryPadding.top,
                            ),
                            //* USER PROFILE
                            userProfile(photoURL, profileName, context),
                            const SizedBox(height: 30),
                            // ResponsiveViewCases1(),
                            //stream presence
                            StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.presenceC.streamPresence(),
                              builder: (context, snapshotPresence) {
                                if (snapshotPresence.data?.data() != null) {
                                  Map<String, dynamic> dataPresence =
                                      snapshotPresence.data!.data()!;
                                  return Column(
                                    children: [
                                      //* CARD PRESENCE INFORMATION
                                      cardPresence(context, user, dataPresence),
                                      const SizedBox(height: 20),
                                      menuFeatures(context, user),
                                      const SizedBox(height: 20),
                                      //* CARD DISTANCE AND MAPS
                                      card2(context, dataPresence),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      infoPresenceIsNull(context),
                                      const SizedBox(height: 20),
                                      Column(
                                        children: [
                                          cardPresenceIsNull(context),
                                          const SizedBox(height: 20),
                                          menuFeatures(context, user),
                                          const SizedBox(height: 20),
                                          card2IsNull(context),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            //* PRESENCE HISTORY
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: controller.presenceC
                                  .streamLast5daysPresence(),
                              builder: (context, snapshotLast5days) {
                                if (snapshotLast5days.hasData) {
                                  List<
                                          QueryDocumentSnapshot<
                                              Map<String, dynamic>>> last5days =
                                      snapshotLast5days.data!.docs;
                                  return swiper(context, last5days);
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            userProfile(photoURL, profileName, context),
                            const SizedBox(height: 30),
                            infoPresenceIsNull(context),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                cardPresenceIsNull(context),
                                const SizedBox(height: 20),
                                card2IsNull(context),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Histori Kehadiran",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.textSize(
                                        context: context, fontSize: 13),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.PRESENCE_HISTORY),
                                    child: Text(
                                      "semua histori",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            historyPresenceIsNull(context)
                          ],
                        );
                      }
                    }),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }
        });
  }

  Widget userProfile(
      String photoURL, String profileName, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl: photoURL,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(color: primaryColor),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang",
                  style: TextStyle(
                    color: BlackSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                ),
                Text(
                  controller.capitalize(profileName),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14)),
                ),
              ],
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfff8dcdf),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () => Get.toNamed(Routes.ANNOUNCEMENT),
            icon: Icon(
              Ionicons.megaphone,
              color: primaryColor,
              size: 24,
            ),
          ),
        )
      ],
    );
  }

  Widget cardPresence(BuildContext context, Map<String, dynamic>? user,
      Map<String, dynamic> dataPresence) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4, // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        // color: Color(0xccef4538),
        image: const DecorationImage(
          image: AssetImage('assets/gradient_line_2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // card checkin checkout
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat.jms().format(
                              DateTime.parse(dataPresence['checkIn']['date'])),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.white24,
                    ),
                    Column(
                      children: [
                        Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          (dataPresence['checkOut'] != null)
                              ? DateFormat.jms().format(DateTime.parse(
                                  dataPresence['checkOut']['date']))
                              : "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Ionicons.location_outline,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text(
                      (dataPresence['checkOut'] != null)
                          ? "${dataPresence['checkOut']['address']}"
                          : "${dataPresence['checkIn']['address']}",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 12),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoPresenceIsNull(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4, // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.information_circle_outline,
            color: infoColor,
            size: 26,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hari ini Anda belum melakukan absensi",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Silahkan melakukan absensi kehadiran terlebih dahulu",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget historyPresenceIsNull(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4, // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.information_circle_outline,
            color: dangerColor,
            size: 26,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tidak ada histori kehadiran",
                  style: TextStyle(
                      color: dangerColor,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardPresenceIsNull(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 4, // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        // color: Color(0xccef4538),
        image: const DecorationImage(
          image: AssetImage('assets/gradient_line_2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // card checkin checkout
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.white24,
                    ),
                    Column(
                      children: [
                        Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Ionicons.location_outline,
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Belum ada lokasi absen saat ini",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card2(BuildContext context, Map<String, dynamic> dataPresence) {
    int distanceMeterCheckIn = dataPresence['checkIn']['distance'].round();

    int distanceKiloMeterCheckIn = (distanceMeterCheckIn / 1000).round();

    int distanceMeterCheckOut;
    dataPresence['checkOut'] != null
        ? distanceMeterCheckOut = dataPresence['checkOut']['distance'].round()
        : distanceMeterCheckOut = 0;

    int distanceKiloMeterCheckOut;
    dataPresence['checkOut'] != null
        ? distanceKiloMeterCheckOut = (distanceMeterCheckIn / 1000).round()
        : distanceKiloMeterCheckOut = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 84,
            decoration: BoxDecoration(
              color: const Color(0xff56a1bf),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Jarak dari kantor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: WhiteSoftColor,
                    fontSize: Constant.textSize(context: context, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  (dataPresence["checkOut"] != null)
                      ? (distanceMeterCheckOut >= 1000
                          ? "${distanceKiloMeterCheckOut}km"
                          : "${distanceMeterCheckOut}m")
                      : (distanceMeterCheckIn >= 1000
                          ? "${distanceKiloMeterCheckIn}km"
                          : "${distanceMeterCheckIn}m"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: softBlueColor,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/map.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => controller.routeToMap(),
                child: Container(
                  height: 84,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.navigate,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Peta Lokasi',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget card2IsNull(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff56a1bf),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 4, // changes position of shadow
                ),
              ],
            ),
            child: Container(
              height: 84,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jarak dari kantor",
                    style: TextStyle(
                      color: WhiteSoftColor,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "-",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 16),
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: softBlueColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 4, // changes position of shadow
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/map.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => controller.routeToMap(),
                child: Container(
                  height: 84,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.navigate,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Peta Lokasi',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget swiper(BuildContext context,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotLast5days) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Histori Kehadiran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constant.textSize(context: context, fontSize: 13),
                ),
              ),
              TextButton(
                  onPressed: () => Get.toNamed(Routes.PRESENCE_HISTORY),
                  child: Text(
                    "semua histori",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 13),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshotLast5days.length,
            itemBuilder: ((context, index) {
              Map<String, dynamic> data =
                  snapshotLast5days.deepReverse()[index].data();
              return Container(
                width: 280,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5, color: AppColor.secondaryExtraSoft),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(right: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () =>
                        Get.toNamed(Routes.PRESENCE_DETAIL, arguments: data),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration:
                                          BoxDecoration(color: secondaryColor),
                                      child: Icon(
                                        Ionicons.calendar_outline,
                                        color: primaryColor,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    DateFormat('EEEE, MMM d, ' 'yyyy')
                                        .format(DateTime.parse(data['date'])),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: Constant.textSize(
                                          context: context, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          // ============= CHECKIN / CHECKOUT ============= //
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                image: AssetImage('assets/gradient_line.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Masuk",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateFormat.jm().format(DateTime.parse(
                                          data['checkIn']['date'])),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.white24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Keluar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      (data['checkOut'] != null)
                                          ? DateFormat.jm().format(
                                              DateTime.parse(
                                                  data['checkOut']['date']))
                                          : "-",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Constant.textSize(
                                            context: context, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget management(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InkWell(
                // onTap: () => Get.toNamed(Routes.MANAGEMENT_USER),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  decoration: BoxDecoration(
                    color: infoSoftColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.people,
                        color: infoColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "User",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                // onTap: () => Get.toNamed(Routes.MONITORING_USER),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  decoration: BoxDecoration(
                    color: successSoftColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.locate,
                        color: successColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Monitoring",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Constant.textSize(context: context, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget overtime(BuildContext context, Map<String, dynamic>? data) {
    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: () => Get.toNamed(Routes.OVERTIME_DETAIL, arguments: data),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 4, // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: (data!['status'] == 'pending')
                                ? AppColor.waiting
                                : (data['status'] == 'approved')
                                    ? AppColor.successSoft
                                    : AppColor.errorSoft,
                          ),
                          child: Icon(
                            (data['status'] == 'pending')
                                ? Ionicons.time_outline
                                : (data['status'] == 'approved')
                                    ? Ionicons.checkmark_done_circle_outline
                                    : Ionicons.close_circle_outline,
                            color: (data['status'] == 'pending')
                                ? AppColor.warning
                                : (data['status'] == 'approved')
                                    ? AppColor.success
                                    : AppColor.error,
                            size: 20,
                          )),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Lembur",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Constant.textSize(context: context, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "start :",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          (data['approved_at'] != null)
                              ? "${data['approved_at']}"
                              : "00.00",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "end :",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "00.00",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget menuFeatures(BuildContext context, Map<String, dynamic>? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (user!["role"] == "admin")
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.ADMIN_MENU),
                            child: Icon(
                              Ionicons.person_outline,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Admin",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: Constant.textSize(
                                context: context, fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.OVERTIME),
                      child: Icon(
                        Ionicons.time_outline,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lembur",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.PERIZINAN_CUTI),
                      child: Icon(
                        Ionicons.airplane_outline,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Cuti",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.PERIZINAN_SAKIT),
                        child: Icon(
                          Ionicons.thermometer_outline,
                          color: primaryColor,
                          size: 20,
                        ),
                      )),
                  const SizedBox(height: 8),
                  Text(
                    "Sakit",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Row(),
        ],
      ),
    );
  }

  Widget perizinan(BuildContext context) {
    return Column(
      children: [
        InkWell(
          // onTap: () => Get.toNamed(Routes.PERIZINAN),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: warningSoftColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.clipboard_outline,
                  color: warningColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Perizinan",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.textSize(context: context, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ResponsiveViewCases1 extends GetResponsiveView<HomeController> {
  @override
  Widget builder() {
    print("isTablet : ${screen.isTablet}");
    return screen.isTablet
        ? Container(
            color: screen.isTablet ? Colors.red : Colors.indigo,
            child: const Icon(Icons.desktop_windows, size: 75))
        : screen.isPhone
            ? const Icon(Icons.phone, size: 75)
            : const Icon(Icons.info, size: 75);
  }
}
