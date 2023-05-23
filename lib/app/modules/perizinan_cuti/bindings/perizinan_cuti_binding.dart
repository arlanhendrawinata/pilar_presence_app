import 'package:get/get.dart';

import '../controllers/perizinan_cuti_controller.dart';

class PerizinanCutiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanCutiController>(
      () => PerizinanCutiController(),
    );
  }
}
