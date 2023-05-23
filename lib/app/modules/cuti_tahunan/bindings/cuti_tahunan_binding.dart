import 'package:get/get.dart';

import '../controllers/cuti_tahunan_controller.dart';

class CutiTahunanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutiTahunanController>(
      () => CutiTahunanController(),
    );
  }
}
