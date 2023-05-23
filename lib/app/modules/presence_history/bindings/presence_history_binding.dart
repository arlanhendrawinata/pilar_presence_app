import 'package:get/get.dart';

import '../controllers/presence_history_controller.dart';

class PresenceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresenceHistoryController>(
      () => PresenceHistoryController(),
    );
  }
}
