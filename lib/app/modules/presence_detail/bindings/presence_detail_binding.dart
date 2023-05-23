import 'package:get/get.dart';

import '../controllers/presence_detail_controller.dart';

class PresenceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresenceDetailController>(
      () => PresenceDetailController(),
    );
  }
}
