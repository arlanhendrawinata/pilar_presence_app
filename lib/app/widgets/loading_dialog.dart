import 'package:flutter/material.dart';
import 'package:pilar_presence_app/constant.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static showLoadingDialog() {
    return Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Colors.white,
      title: "",
      titleStyle: TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.only(top: 20),
      // contentPadding: EdgeInsets.all(20),
      content: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              color: primaryColor,
            ),
            SizedBox(height: 16),
            Text(
              "loading...",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white.withOpacity(0.7),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         CircularProgressIndicator(
    //           color: primaryColor,
    //         ),
    //         SizedBox(height: 10),
    //         Text("loading...")
    //       ],
    //     ),
    //   ),
    // );
  }
}
