import 'package:get/get.dart';

import '../controllers/management_announcement_controller.dart';

class ManagementAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagementAnnouncementController>(
      () => ManagementAnnouncementController(),
    );
  }
}
