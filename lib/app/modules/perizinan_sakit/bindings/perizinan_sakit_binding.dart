import 'package:get/get.dart';

import '../controllers/perizinan_sakit_controller.dart';

class PerizinanSakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanSakitController>(
      () => PerizinanSakitController(),
    );
  }
}
