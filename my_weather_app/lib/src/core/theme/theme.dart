import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class AppTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryColor)),
        textButtonTheme: TextButtonThemeData(
            style:
                TextButton.styleFrom(foregroundColor: AppColors.primaryColor)));
  }
}
