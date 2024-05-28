import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class WeatherInfoBlocks extends StatelessWidget {
  final Size size;
  final String imagePath;
  final String heading;
  final String body;
  const WeatherInfoBlocks(
      {super.key,
      required this.size,
      required this.heading,
      required this.body,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryTransColor,
      child: SizedBox(
        width: 140,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 24,
                  width: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AutoSizeText(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AutoSizeText(
                    body,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
