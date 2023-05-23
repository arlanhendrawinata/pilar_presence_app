import 'package:get/get.dart';

import '../controllers/perizinan_request_controller.dart';

class PerizinanRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanRequestController>(
      () => PerizinanRequestController(),
    );
  }
}
