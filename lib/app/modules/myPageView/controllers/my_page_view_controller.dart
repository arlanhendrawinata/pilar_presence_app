import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pilar_presence_app/app/controllers/general_overtime_controller.dart';
import 'package:pilar_presence_app/app/controllers/page_index_controller.dart';
import 'package:pilar_presence_app/app/controllers/presence_controller.dart';

class MyPageViewController extends GetxController {
  final pageIndexC = Get.find<PageIndexController>();
  final presenceC = Get.find<PresenceController>();
  final overtimeC = Get.find<GeneralOvertimeController>();
  PageController pageC = PageController(initialPage: 0);
}
