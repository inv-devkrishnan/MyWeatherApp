import 'package:flutter/material.dart';

class WeatherImage {
  static String getWeatherImage(int code) {
    debugPrint("current weather code : $code");
    String path = "";
    switch (code) {
      case 1000:
        path = "assets/images/sunnyDay.jpg";
        break;
      case 1003:
      case 1006:
      case 1009:
        path = "assets/images/cloudy.jpg";
        break;
      case 1135:
      case 1147:
      case 1030:
        path = "assets/images/mist.jpg";
        break;
      case 1063:
      case 1153:
      case 1180:
      case 1183:
      case 1186:
      case 1189:
      case 1192:
      case 1195:
      case 1240:
      case 1243:
      case 1246:
        path = "assets/images/drizzle.jpg";
        break;
      case 1273:
      case 1276:
      case 1279:
      case 1087:
      case 1282:
        path = "assets/images/thunderstorm.jpg";
        break;
      case 1066:
      case 1069:
      case 1072:
      case 1114:
      case 1117:
      case 1168:
      case 1171:
      case 1198:
      case 1201:
      case 1204:
      case 1207:
      case 1210:
      case 1213:
      case 1216:
      case 1219:
      case 1222:
      case 1225:
      case 1237:
      case 1261:
      case 1264:
        path = "assets/images/snow.jpg";
        break;
      default:
        path = "assets/images/clear.jpg";
    }
    return path;
  }
}
