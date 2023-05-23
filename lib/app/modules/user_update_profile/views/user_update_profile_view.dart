import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_update_profile_controller.dart';

class UserUpdateProfileView extends GetView<UserUpdateProfileController> {
  const UserUpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserUpdateProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserUpdateProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
