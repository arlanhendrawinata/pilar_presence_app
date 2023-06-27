import 'package:get/get.dart';

import '../controllers/management_user_controller.dart';

class ManagementUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagementUserController>(
      () => ManagementUserController(),
    );
  }
}
