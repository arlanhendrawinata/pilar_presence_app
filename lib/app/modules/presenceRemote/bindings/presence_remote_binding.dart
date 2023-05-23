import 'package:get/get.dart';

import '../controllers/presence_remote_controller.dart';

class PresenceRemoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresenceRemoteController>(
      () => PresenceRemoteController(),
    );
  }
}
