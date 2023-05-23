import 'package:get/get.dart';

import '../controllers/overtime_detail_controller.dart';

class OvertimeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OvertimeDetailController>(
      () => OvertimeDetailController(),
    );
  }
}
