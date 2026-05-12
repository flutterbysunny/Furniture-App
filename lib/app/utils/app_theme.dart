import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors


  static ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColor),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: AppColors.bgColor,
  );
}