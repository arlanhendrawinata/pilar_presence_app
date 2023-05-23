import 'package:get/get.dart';

import '../controllers/user_update_profile_controller.dart';

class UserUpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdateProfileController>(
      () => UserUpdateProfileController(),
    );
  }
}
