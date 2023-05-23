import 'package:get/get.dart';

import '../controllers/overtime_history_controller.dart';

class OvertimeHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OvertimeHistoryController>(
      () => OvertimeHistoryController(),
    );
  }
}
