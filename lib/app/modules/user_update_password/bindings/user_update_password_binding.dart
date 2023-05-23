import 'package:get/get.dart';

import '../controllers/user_update_password_controller.dart';

class UserUpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdatePasswordController>(
      () => UserUpdatePasswordController(),
    );
  }
}
