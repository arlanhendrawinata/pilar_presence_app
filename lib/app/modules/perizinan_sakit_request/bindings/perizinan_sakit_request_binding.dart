import 'package:get/get.dart';

import '../controllers/perizinan_sakit_request_controller.dart';

class PerizinanSakitRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanSakitRequestController>(
      () => PerizinanSakitRequestController(),
    );
  }
}
