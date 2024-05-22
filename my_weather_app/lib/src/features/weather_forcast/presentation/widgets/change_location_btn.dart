import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class ChangeLocationBtn extends StatelessWidget {
  const ChangeLocationBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.primaryTextColor,
        backgroundColor: AppColors.primaryTransColor,
      ),
      onPressed: () {},
      label: const Text("Change Location"),
      icon: const Icon(
        Icons.location_on,
        color: AppColors.primaryTextColor,
      ),
    );
  }
}
