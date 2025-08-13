import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/common/app_color/app_colors.dart';

import 'light_theme.dart';


ThemeData dark({Color color = AppColors.primaryColor, BuildContext? context}) => ThemeData(
  fontFamily: GoogleFonts.inder.toString(),
  textTheme: context != null
      ? GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
    bodyColor: Colors.white, // Set default text color to white
    displayColor: Colors.white, // Set display text color to white
  )
      : ThemeData.dark().textTheme.apply(
    bodyColor: Colors.white, // Set default text color to white
    displayColor: Colors.white, // Set display text color to white
  ),
  primaryColor: color,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  secondaryHeaderColor: color.withValues(alpha: 0.4),
  disabledColor: AppColors.subTextColor,
  brightness: Brightness.dark,
  hintColor: AppColors.hintColor,
  cardColor: AppColors.cardColor,
  dividerColor: AppColors.dividerColor,
  shadowColor: AppColors.shadowColor,
  canvasColor: AppColors.bottomBarColor,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.fillColor,
    hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 16.sp),
    isDense: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 12.w,
      vertical: 16.h,
    ),
    enabledBorder: enableBorder(),
    focusedBorder: focusedBorder(),
    errorBorder: errorBorder(),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.bottomBarColor,
    selectedLabelStyle: TextStyle(color: color),
    unselectedLabelStyle: TextStyle(color: AppColors.subTextColor),
  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
  colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(surface: Color(0xFF343636)).copyWith(error: Color(0xFFdd3135)),
);
