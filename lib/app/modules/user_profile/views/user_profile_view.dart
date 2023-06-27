// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/routes/app_pages.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';
import '../controllers/user_profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:change_case/change_case.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: controller.streamUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(color: primaryColor),
          ));
        }
        if (snapshot.hasData) {
          Map<String, dynamic> user = snapshot.data!.data()!;
          String profileName = user["name"].toString().toLowerCase();
          final imageUrl = "https://ui-avatars.com/api/?name=$profileName";
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: Constant.textSize(context: context, fontSize: 14),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => FractionallySizedBox(
                          heightFactor: 0.7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColor.secondaryExtraSoft),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(Routes.USER_UPDATE_PROFILE,
                                            arguments: user);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Container(
                                                    color: secondaryColor,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Icon(
                                                      Ionicons.person_outline,
                                                      color: primaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ubah Data Diri",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Constant.textSize(
                                                                context:
                                                                    context,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward_outline,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColor.secondaryExtraSoft),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(Routes.USER_UPDATE_EMAIL);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Container(
                                                    color: secondaryColor,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Icon(
                                                      Ionicons.mail_outline,
                                                      color: primaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ubah Email",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Constant.textSize(
                                                                context:
                                                                    context,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward_outline,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColor.secondaryExtraSoft),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(
                                            Routes.USER_UPDATE_PASSWORD);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Container(
                                                    color: secondaryColor,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Icon(
                                                      Ionicons.key_outline,
                                                      color: primaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ubah Password",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Constant.textSize(
                                                                context:
                                                                    context,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward_outline,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColor.secondaryExtraSoft),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => controller
                                          .logout(controller.isLoading),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Container(
                                                    color: secondaryColor,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Icon(
                                                      Ionicons.exit_outline,
                                                      color: primaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Constant.textSize(
                                                                context:
                                                                    context,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward_outline,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Ionicons.menu_outline,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  width: Get.width,
                  height: 1,
                  color: AppColor.secondaryExtraSoft,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                        ),
                        ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: user["photoURL"] != null
                                  ? (user["photoURL"] != ""
                                      ? user["photoURL"]
                                      : imageUrl)
                                  : imageUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                      color: primaryColor),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.grey,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${profileName.toCapitalCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:
                            Constant.textSize(context: context, fontSize: 16),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${user["email"].toString().toLowerCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        profileData(
                          context,
                          "Email",
                          "${user["email"].toString().toLowerCase()}",
                        ),
                        profileData(
                          context,
                          "Nomor Telp",
                          "${user["phone_number"] != null ? user["phone_number"] : '-'}",
                        ),
                        profileData(
                            context,
                            "Tempat/Tgl Lahir",
                            user["profile"]?["birth_place"] != null &&
                                    user["profile"]?["birth_date"] != null
                                ? "${user["profile"]["birth_place"]}, ${DateFormat('dd-MM-yyyy').format(DateTime.parse(user["profile"]["birth_date"].replaceAll("/", "-")))}"
                                : '-'),
                        profileData(
                          context,
                          "Jenis Kelamin",
                          "${user["profile"]?["gender"] != null ? user["profile"]["gender"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Golongan Darah",
                          "${user["profile"]?["goldar"] != null ? user["profile"]["goldar"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Alamat",
                          "${user["profile"]?["address"] != null ? user["profile"]["address"] : '-'}",
                        ),
                        profileData(
                          context,
                          "RT/RW",
                          user["profile"]?["rt"] != null &&
                                  user["profile"]?["rw"] != null
                              ? "${user["profile"]["rt"]} / ${user["profile"]["rw"]}"
                              : "-",
                        ),
                        profileData(
                          context,
                          "Kel/Desa",
                          "${user["profile"]?["kelurahan"] != null ? user["profile"]["kelurahan"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Kecamatan",
                          "${user["profile"]?["kecamatan"] != null ? user["profile"]["kecamatan"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Agama",
                          "${user["profile"]?["agama"] != null ? user["profile"]["agama"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Status Perkawinan",
                          "${user["profile"]?["status_kawin"] != null ? user["profile"]["status_kawin"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Pekerjaan",
                          "${user["profile"]?["pekerjaan"] != null ? user["profile"]["pekerjaan"] : '-'}",
                        ),
                        profileData(
                          context,
                          "Kewarganegaraan",
                          "${user["profile"]?["kewarganegaraan"] != null ? user["profile"]["kewarganegaraan"] : '-'}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        }
      },
    );
  }

  Widget profileData(BuildContext context, String title, String titleData) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppColor.secondaryExtraSoft),
        ),
      ),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title",
              softWrap: true,
              style: TextStyle(
                color: AppColor.secondarySoft,
                fontSize: Constant.textSize(context: context, fontSize: 12),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "$titleData",
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: Constant.textSize(context: context, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
