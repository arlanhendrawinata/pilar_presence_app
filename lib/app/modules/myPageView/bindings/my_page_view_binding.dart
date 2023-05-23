import 'package:get/get.dart';

import '../controllers/my_page_view_controller.dart';

class MyPageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageViewController>(
      () => MyPageViewController(),
    );
  }
}
