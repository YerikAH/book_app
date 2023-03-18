import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static final ThemeData themeConfig = ThemeData.light().copyWith(
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}