import 'package:flutter/material.dart';

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
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xfff8dcdf),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () => print("filter"),
                icon: Icon(
                  Ionicons.options_outline,
                  size: 22,
                  color: primaryColor,
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
        body: SizedBox(
            height: Get.height,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    // margin: EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        bottom: 20, left: 20, right: 20, top: 0),
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
                        Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Libur",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: Constant.textSize(
                                  context: context, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "How Facebook Preys on Our Mental Health",
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
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
                              "Friday, Dec 02, 2022",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                                color: BlackSoftColor,
                              ),
                            ),
                            Text(
                              "11:45 PM",
                              style: TextStyle(
                                fontSize: Constant.textSize(
                                    context: context, fontSize: 12),
                                color: BlackSoftColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
            )));
  }
}
