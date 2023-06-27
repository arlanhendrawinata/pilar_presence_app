import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:change_case/change_case.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pilar_presence_app/app/style/app_color.dart';
import 'package:pilar_presence_app/constant.dart';

import '../controllers/announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengumuman',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: Constant.textSize(context: context, fontSize: 14),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Ionicons.arrow_back,
            color: Colors.black87,
            size: 22,
          ),
        ),
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
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamAnnouncement(),
          builder: (context, snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                listAnnouncement = snapshot.data?.docs;
            if (snapshot.hasData) {
              if (listAnnouncement!.isNotEmpty) {
                return Container(
                  height: Get.height,
                  child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: listAnnouncement.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      margin: EdgeInsets.only(
                          bottom:
                              (index != listAnnouncement.length - 1) ? 20 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 4,
                            blurRadius: 4, // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${listAnnouncement[index]['title']}"
                                .toCapitalCase(),
                            style: TextStyle(
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 14),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${listAnnouncement[index]['body']}"
                                .toUpperFirstCase(),
                            style: TextStyle(
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.yMMMEd().format(DateTime.parse(
                                    listAnnouncement[index]['date'])),
                                style: TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: BlackSoftColor,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(DateTime.parse(
                                    listAnnouncement[index]['date'])),
                                style: TextStyle(
                                  fontSize: Constant.textSize(
                                      context: context, fontSize: 12),
                                  color: BlackSoftColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
