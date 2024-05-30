import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/services/date_formatter.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_forcast_day_model.dart';
import 'package:transparent_image/transparent_image.dart';

class HourlyForcastChart extends StatelessWidget {
  final List<Hour> hourData;
  const HourlyForcastChart({super.key, required this.hourData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: LineChart(mainData()),
    );
  }

  bool showChanceOfRain() => hourData.any((hour) => hour.chanceOfRain != 0);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Column(
        children: [
          if (showChanceOfRain())
            Text("${hourData[value.round()].chanceOfRain} %", style: style),
          Image.network(
            errorBuilder: (context, error, stackTrace) => Image(
              image: MemoryImage(kTransparentImage),
              height: 32,
              width: 32,
            ),
            'http:${hourData[value.round()].condition.icon}',
            height: 32,
            width: 32,
          ),
          Text(DateFormatter.formatTime(hourData[value.round()].time),
              style: style),
        ],
      ),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text("${hourData[value.round()].temp}°C", style: style),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
      ),
      lineTouchData: const LineTouchData(enabled: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: showChanceOfRain() ? 80 : 60,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: gethourlydata(),
          barWidth: 2,
          isCurved: true,
          color: AppColors.primaryTextColor,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            color: const Color.fromARGB(66, 255, 255, 255),
            show: true,
          ),
        ),
      ],
    );
  }

  List<FlSpot> gethourlydata() {
    List<FlSpot> hourlist = [];
    double i = 0;
    for (Hour hour in hourData) {
      FlSpot spot = FlSpot(i, hour.temp);
      hourlist.add(spot);
      i += 1;
    }

    return hourlist;
  }
}
