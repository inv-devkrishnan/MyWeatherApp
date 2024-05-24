import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/bottom_card_sheet.dart';

class ChangeLocationBtn extends StatelessWidget {
  final Size size;
  const ChangeLocationBtn({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.primaryTextColor,
        backgroundColor: AppColors.primaryTransColor,
      ),
      onPressed: () {
        showModalBottomSheet<void>(
            context: context,
            backgroundColor: AppColors.bottomSheetColor,
            builder: (BuildContext context) {
              return BottomCardSheet(size);
            });
      },
      label: const Text("Change Location"),
      icon: const Icon(
        Icons.location_on,
        color: AppColors.primaryTextColor,
      ),
    );
  }
}
