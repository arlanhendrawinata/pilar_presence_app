import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_update_email_controller.dart';

class UserUpdateEmailView extends GetView<UserUpdateEmailController> {
  const UserUpdateEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserUpdateEmailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserUpdateEmailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
