import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_update_password_controller.dart';

class UserUpdatePasswordView extends GetView<UserUpdatePasswordController> {
  const UserUpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserUpdatePasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserUpdatePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
