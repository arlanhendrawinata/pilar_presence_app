import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_add_controller.dart';

class UserAddView extends GetView<UserAddController> {
  const UserAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserAddView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserAddView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
