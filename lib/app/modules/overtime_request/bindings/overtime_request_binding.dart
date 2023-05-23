import 'package:get/get.dart';

import '../controllers/overtime_request_controller.dart';

class OvertimeRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OvertimeRequestController>(
      () => OvertimeRequestController(),
    );
  }
}
