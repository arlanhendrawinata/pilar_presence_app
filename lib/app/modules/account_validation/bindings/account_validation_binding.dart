import 'package:get/get.dart';

import '../controllers/account_validation_controller.dart';

class AccountValidationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountValidationController>(
      () => AccountValidationController(),
    );
  }
}
