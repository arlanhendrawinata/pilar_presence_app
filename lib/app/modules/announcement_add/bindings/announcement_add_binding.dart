import 'package:get/get.dart';

import '../controllers/announcement_add_controller.dart';

class AnnouncementAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnouncementAddController>(
      () => AnnouncementAddController(),
    );
  }
}
