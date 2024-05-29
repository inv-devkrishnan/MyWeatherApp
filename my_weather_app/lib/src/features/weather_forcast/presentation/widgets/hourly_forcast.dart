import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_forcast_day_model.dart';
import 'package:transparent_image/transparent_image.dart';

class HourlyForcast extends StatelessWidget {
  final List<Hour> hourData;
  const HourlyForcast({super.key, required this.hourData});

  double getMaxtemp() {
    Hour hour = hourData.reduce((a, b) => a.temp > b.temp ? a : b);
    return hour.temp;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        maxY: 60));
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              "${rod.toY.round().toString()} °C",
              const TextStyle(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    String icon;
    switch (value.toInt()) {
      case 0:
        text = "12 am ";
        icon = hourData[0].condition.icon;
        break;
      case 1:
        text = "1 am ";
        icon = hourData[1].condition.icon;
        break;
      case 2:
        text = "2 am ";
        icon = hourData[2].condition.icon;
        break;
      case 3:
        text = "3 am ";
        icon = hourData[3].condition.icon;
        break;
      case 4:
        text = "4 am ";
        icon = hourData[4].condition.icon;
        break;
      case 5:
        text = '5 am ';
        icon = hourData[5].condition.icon;
        break;
      case 6:
        text = '6 am ';
        icon = hourData[6].condition.icon;
        break;
      case 7:
        text = '7 am ';
        icon = hourData[7].condition.icon;
        break;
      case 8:
        text = '8 am ';
        icon = hourData[8].condition.icon;
        break;
      case 9:
        text = '9 am ';
        icon = hourData[9].condition.icon;
        break;
      case 10:
        text = '10 am ';
        icon = hourData[10].condition.icon;
        break;
      case 11:
        text = '11 am ';
        icon = hourData[11].condition.icon;
        break;
      case 12:
        text = '12 pm ';
        icon = hourData[12].condition.icon;
        break;
      case 13:
        text = '1 pm ';
        icon = hourData[13].condition.icon;
        break;
      case 14:
        text = '2 pm ';
        icon = hourData[14].condition.icon;
        break;
      case 15:
        text = '3 pm ';
        icon = hourData[15].condition.icon;
        break;
      case 16:
        text = '4 pm ';
        icon = hourData[16].condition.icon;
        break;
      case 17:
        text = '5 pm ';
        icon = hourData[17].condition.icon;
        break;
      case 18:
        text = '6 pm ';
        icon = hourData[18].condition.icon;
        break;
      case 19:
        text = '8 pm ';
        icon = hourData[19].condition.icon;
        break;
      case 20:
        text = '9 pm ';
        icon = hourData[20].condition.icon;
        break;
      case 21:
        text = '10 pm ';
        icon = hourData[21].condition.icon;
        break;
      case 22:
        text = '11 pm ';
        icon = hourData[22].condition.icon;
        break;

      default:
        text = '12 am ';
        icon = hourData[22].condition.icon;
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Column(
        children: [
          Image.network(
            errorBuilder: (context, error, stackTrace) =>
                Image(image: MemoryImage(kTransparentImage)),
            'http:$icon',
            height: 24,
            width: 24,
          ),
          Text(text, style: style),
        ],
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> hourlyData() {
    List<BarChartGroupData> dataList = [];
    int x = 0;
    for (Hour hour in hourData) {
      BarChartGroupData data = BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: hour.temp,
            color: const Color.fromARGB(121, 255, 255, 255),
          )
        ],
        showingTooltipIndicators: [0],
      );
      x += 1;
      dataList.add(data);
    }
    return dataList;
  }

  List<BarChartGroupData> get barGroups => hourlyData();
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
