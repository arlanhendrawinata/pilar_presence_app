import 'package:get/get.dart';

import '../controllers/user_update_email_controller.dart';

class UserUpdateEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdateEmailController>(
      () => UserUpdateEmailController(),
    );
  }
}
