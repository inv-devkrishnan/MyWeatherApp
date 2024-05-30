import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/services/date_formatter.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_forcast_day_model.dart';
import 'package:transparent_image/transparent_image.dart';

class HourlyForcast extends StatelessWidget {
  final List<Hour> hourData;
  const HourlyForcast({super.key, required this.hourData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourData.length,
        itemBuilder: (context, index) => HourDataWidget(hour: hourData[index]));
  }
}

class HourDataWidget extends StatelessWidget {
  final Hour hour;
  const HourDataWidget({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Column(
        children: [
          Text(
            "${hour.temp}°C",
            style: style,
          ),
          Image.network(
            errorBuilder: (context, error, stackTrace) => Image(
              image: MemoryImage(kTransparentImage),
              height: 32,
              width: 32,
            ),
            'http:${hour.condition.icon}',
            height: 32,
            width: 32,
          ),
          Text(DateFormatter.formatTime(hour.time), style: style),
        ],
      ),
    );
  }
}

class HourlyForcastWidget extends StatefulWidget {
  final List<Hour> hourData;
  const HourlyForcastWidget({super.key, required this.hourData});

  @override
  State<StatefulWidget> createState() => HourlyForcastWidgetState();
}

class HourlyForcastWidgetState extends State<HourlyForcastWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: HourlyForcast(
        hourData: widget.hourData,
      ),
    );
  }
}
