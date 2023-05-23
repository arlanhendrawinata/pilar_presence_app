import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
