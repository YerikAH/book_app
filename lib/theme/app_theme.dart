import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static const Color orange = Color.fromARGB(179, 255, 80, 27);
  static const Color black100 = Colors.black;
  static final Color black70 = Colors.black.withOpacity(0.7);
  static const Color white = Colors.white;
  static final Color black60 = Colors.black.withOpacity(0.6);
  static final Color black30 = Colors.black.withOpacity(0.3);
  static final Color black10 = Colors.black.withOpacity(0.1);
  static const Color green = const Color(0xff06d6a0);
  static final ThemeData themeConfig = ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: orange,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}