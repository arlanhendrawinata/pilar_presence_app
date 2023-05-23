import 'package:flutter/material.dart';

Color whiteExtraSoftColor = Color(0xfff2f2f2);
Color WhiteSoftColor = Colors.white54;
Color BlackSoftColor = Colors.black45;
Color whiteBoneColor = Color(0xffd9d5c5);
Color softBlueColor = Color(0xff56a1bf);
Color primaryColor = Color(0xffec3245);
Color primarySoftColor = Color.fromARGB(255, 255, 235, 235);
Color primaryDarkColor = Color(0xffbf0426);
Color secondaryColor = Color(0xfff8dcdf);
Color thirdColor = Color(0xfff45c41);
Color fourthColor = Color(0xff272a2f);
Color alertSecondaryColor = Color.fromARGB(255, 255, 208, 212);

Color infoColor = Color(0xff5b35d5);
Color infoSoftColor = Color.fromARGB(255, 243, 239, 255);
Color successColor = Color(0xff00a28e);
Color successSoftColor = Color.fromARGB(255, 230, 255, 251);
Color warningColor = Color(0xfff18c33);
Color warningSoftColor = Color.fromARGB(255, 255, 246, 239);
Color dangerColor = Color(0xffff5631);

class Constant {
  static textSize({
    required BuildContext context,
    required double fontSize,
  }) {
    double textScaling = MediaQuery.textScaleFactorOf(context);
    if (textScaling > 1.2) {
      return fontSize - 3.0;
    }
    return fontSize;
  }
}
