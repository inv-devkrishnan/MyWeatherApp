import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class AppTheme {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
                  bodyColor: AppColors.primaryTextColor,
                  displayColor: AppColors.primaryTextColor,
                )),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryTextColor,
          foregroundColor: AppColors.primaryColor,
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryTextColor)),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.primaryTextColor,
        ),
        chipTheme: const ChipThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: AppColors.primaryColor,
            disabledColor: Color.fromARGB(210, 151, 151, 151),
            labelStyle:
                TextStyle(color: AppColors.primaryTextColor, fontSize: 16)),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.primaryTextColor,
        )));
  }

  static TextStyle snackbarStyle() {
    return const TextStyle(fontWeight: FontWeight.bold);
  }
}
