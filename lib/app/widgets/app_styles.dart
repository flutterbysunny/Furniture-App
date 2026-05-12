import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/src/painting/text_style.dart';
import '../utils/app_colors.dart';

class AppStyles {

  static TextStyle titleText({
    double fontSize = 18,
    Color color = AppColors.whiteColor,
    FontWeight fontWeight = FontWeight.w600,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
    String? fontFamily,
  }) {
    return (fontFamily != null)
        ? TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    )
        : GoogleFonts.inter(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle bodyText({
    double fontSize = 16,
    Color color = AppColors.whiteColor,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
    String? fontFamily,
  }) {
    return (fontFamily != null)
        ? TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    )
        : GoogleFonts.inter(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }

  static TextStyle caption({
    double fontSize = 14,
    Color color = AppColors.whiteColor,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
    );
  }
}