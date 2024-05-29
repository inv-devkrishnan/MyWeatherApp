import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/services/date_formatter.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_forcast_day_model.dart';
import 'package:transparent_image/transparent_image.dart';

class FutureWeatherTile extends StatefulWidget {
  final WeatherData data;
  final int index;
  const FutureWeatherTile({super.key, required this.data, required this.index});

  @override
  State<FutureWeatherTile> createState() => _FutureWeatherTileState();
}

class _FutureWeatherTileState extends State<FutureWeatherTile> {
  @override
  Widget build(BuildContext context) {
    final Day day = widget.data.forecast.forecastday[widget.index].day;
    final Astro astro = widget.data.forecast.forecastday[widget.index].astro;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: ExpansionTile(
        backgroundColor: AppColors.primaryTransColor,
        collapsedBackgroundColor: AppColors.primaryTransColor,
        shape: Border.all(color: AppColors.primaryTransColor),
        iconColor: AppColors.primaryTextColor,
        collapsedIconColor: AppColors.primaryTextColor,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                DateFormatter.getDayasText(
                    widget.data.forecast.forecastday[widget.index].date),
                style: textHeaderStyle()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${day.avgTemp} °C",
                  style: textHeaderStyle(),
                ),
                Image.network(
                  errorBuilder: (context, error, stackTrace) =>
                      Image(image: MemoryImage(kTransparentImage)),
                  'http:${day.weatherCondition.icon}',
                  height: 32,
                  width: 32,
                )
              ],
            )
          ],
        ),
        children: [
          weatherDataItem("Max temperature", "${day.maxTemp} °C"),
          weatherDataItem("Min temperature", "${day.minTemp} °C"),
          weatherDataItem("Max wind speed", "${day.maxWindSpeed} km/h"),
          weatherDataItem("Chance of rain", "${day.chanceOfRain} %"),
          weatherDataItem(
              "Total precipitation", "${day.totalPrecipitation} mm"),
          weatherDataItem("UV index", "${day.uv}"),
          weatherDataItem("Sunrise", astro.sunrise),
          weatherDataItem("Sunset", astro.sunset),
          weatherDataItem("Moon Phase", astro.moonPhase),
        ],
      ),
    );
  }

  Row weatherDataItem(
    String label,
    String data,
  ) {
    // function which return a row of weather data
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textChildStyle(),
        ),
        Text(
          data,
          style: textChildStyle(),
        ),
      ],
    );
  }

  TextStyle textHeaderStyle() {
    // text style for header
    return const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.bold);
  }

  TextStyle textChildStyle() {
    // text style for child
    return const TextStyle(
      color: AppColors.primaryTextColor,
    );
  }
}
