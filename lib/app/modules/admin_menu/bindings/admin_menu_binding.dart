import 'package:get/get.dart';

import '../controllers/admin_menu_controller.dart';

class AdminMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMenuController>(
      () => AdminMenuController(),
    );
  }
}
