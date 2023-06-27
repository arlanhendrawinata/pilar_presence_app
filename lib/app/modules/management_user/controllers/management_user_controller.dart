import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManagementUserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> tabs = ["Pengguna Aktif", "Pengguna Non Aktif"];
  RxInt current = 0.obs;

  double changePositionOfLine() {
    switch (current.value) {
      case 0:
        return 0;
      case 1:
        return 136;
      default:
        return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUser() async {
    final newData = [];
    final query = await firestore.collection("users").get();
    final data = query.docs
        .map((e) => e.data())
        .where((element) => current.value != 1
            ? element['status'] == "active"
            : element['status'] == "inactive")
        .toList();
    return data;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
