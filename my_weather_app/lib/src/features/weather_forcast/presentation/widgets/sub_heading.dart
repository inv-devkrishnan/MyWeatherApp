import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class SubHeading extends StatelessWidget {
  final Size size;
  final String heading;
  const SubHeading({super.key, required this.size, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.primaryTransColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: SizedBox(
            width: size.width,
            child: Text(
              textAlign: TextAlign.center,
              heading,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
