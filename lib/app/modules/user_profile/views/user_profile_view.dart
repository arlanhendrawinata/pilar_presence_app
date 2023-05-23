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
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Stack(
                      children: [
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
                    "${toBeginningOfSentenceCase(profileName)}",
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
                      fontSize:
                          Constant.textSize(context: context, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (user["role"] == "admin")
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: AppColor.secondaryExtraSoft),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed(Routes.USER_ADD, arguments: user),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        color: secondaryColor,
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(
                                          Ionicons.person_add_outline,
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
                                          "Tambah User",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Constant.textSize(
                                                context: context, fontSize: 16),
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
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.USER_UPDATE_PROFILE,
                            arguments: user),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: secondaryColor,
                                      padding: const EdgeInsets.all(5),
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
                                        "Ubah Profil",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 16),
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
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.USER_UPDATE_EMAIL),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: secondaryColor,
                                      padding: const EdgeInsets.all(5),
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
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 16),
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
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.USER_UPDATE_PASSWORD),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: secondaryColor,
                                      padding: const EdgeInsets.all(5),
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
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 16),
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
                            width: 1, color: AppColor.secondaryExtraSoft),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => controller.logout(controller.isLoading),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: secondaryColor,
                                      padding: const EdgeInsets.all(5),
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
                                          fontSize: Constant.textSize(
                                              context: context, fontSize: 16),
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
}
