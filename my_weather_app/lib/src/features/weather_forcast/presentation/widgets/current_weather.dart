import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/services/date_formatter.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';
import 'package:transparent_image/transparent_image.dart';

class CurrentWeather extends StatelessWidget {
  final Size size;
  final WeatherData data;
  const CurrentWeather({super.key, required this.size, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryTransColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.02),
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                AutoSizeText(
                  maxFontSize: 42,
                  data.location.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  "${data.location.region}, ${data.location.country}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0, vertical: size.height * 0.005),
                  child: Image.network(
                      errorBuilder: (context, error, stackTrace) =>
                          Image(image: MemoryImage(kTransparentImage)),
                      'http:${data.current.weatherCondition.icon}'),
                ),
                AutoSizeText(
                  maxLines: 1,
                  "${data.current.temp}°C",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  "Feels like ${data.current.feelsLike} °C",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.013),
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    data.current.weatherCondition.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.013),
                  child: AutoSizeText(
                    "Last updated on ${DateFormatter.formatDateTime(data.current.lastUpdated)}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
