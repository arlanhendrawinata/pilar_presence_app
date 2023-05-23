import 'package:get/get.dart';

import '../controllers/perizinan_cuti_request_controller.dart';

class PerizinanCutiRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanCutiRequestController>(
      () => PerizinanCutiRequestController(),
    );
  }
}
