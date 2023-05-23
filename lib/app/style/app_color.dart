import 'package:flutter/cupertino.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF0F50C6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = Color(0xFF266EF1);
  static Color primarySoft = Color(0xFF548DF3);
  static Color primaryExtraSoft = Color(0xFFEFF3FC);
  static Color secondary = Color(0xFF1B1F24);
  static Color secondarySoft = Color(0xFF9D9D9D);
  static Color secondaryExtraSoft = Color(0xFFE9E9E9);
  static Color softRed = Color.fromARGB(255, 255, 236, 236);
  static Color error = Color(0xFFD00E0E);
  static Color errorSoft = Color.fromARGB(255, 255, 242, 242);
  static Color success = Color(0xFF16AE26);
  static Color successSoft = Color.fromARGB(255, 240, 255, 242);
  static Color warning = Color(0xFFEB8600);
  static Color warningSoft = Color.fromARGB(255, 255, 238, 216);
  static Color waiting = Color.fromARGB(255, 255, 220, 174);
}
