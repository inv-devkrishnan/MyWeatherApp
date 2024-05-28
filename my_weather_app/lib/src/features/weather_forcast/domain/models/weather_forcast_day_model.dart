// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_condition_model.dart';

class Day {
  final double maxTemp;
  final double minTemp;
  final double avgTemp;
  final double maxWindSpeed;
  final int chanceOfRain;
  final double totalPrecipitation;
  final WeatherCondition weatherCondition;
  final double uv;
  Day({
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.maxWindSpeed,
    required this.chanceOfRain,
    required this.totalPrecipitation,
    required this.weatherCondition,
    required this.uv,
  });

  Day copyWith({
    double? maxTemp,
    double? minTemp,
    double? avgTemp,
    double? maxWindSpeed,
    int? chanceOfRain,
    double? totalPrecipitation,
    WeatherCondition? weatherCondition,
    double? uv,
  }) {
    return Day(
      maxTemp: maxTemp ?? this.maxTemp,
      minTemp: minTemp ?? this.minTemp,
      avgTemp: avgTemp ?? this.avgTemp,
      maxWindSpeed: maxWindSpeed ?? this.maxWindSpeed,
      chanceOfRain: chanceOfRain ?? this.chanceOfRain,
      totalPrecipitation: totalPrecipitation ?? this.totalPrecipitation,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      uv: uv ?? this.uv,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'avgTemp': avgTemp,
      'maxWindSpeed': maxWindSpeed,
      'chanceOfRain': chanceOfRain,
      'totalPrecipitation': totalPrecipitation,
      'weatherCondition': weatherCondition.toMap(),
      'uv': uv,
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      maxTemp: map['maxtemp_c'] as double,
      minTemp: map['mintemp_c'] as double,
      avgTemp: map['avgtemp_c'] as double,
      maxWindSpeed: map['maxwind_kph'] as double,
      chanceOfRain: map['daily_chance_of_rain'] as int,
      totalPrecipitation: map['totalprecip_mm'] as double,
      weatherCondition:
          WeatherCondition.fromMap(map['condition'] as Map<String, dynamic>),
      uv: map['uv'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Day.fromJson(String source) =>
      Day.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Day(maxTemp: $maxTemp, minTemp: $minTemp, avgTemp: $avgTemp, maxWindSpeed: $maxWindSpeed, chanceOfRain: $chanceOfRain, totalPrecipitation: $totalPrecipitation, weatherCondition: $weatherCondition, uv: $uv)';
  }

  @override
  bool operator ==(covariant Day other) {
    if (identical(this, other)) return true;

    return other.maxTemp == maxTemp &&
        other.minTemp == minTemp &&
        other.avgTemp == avgTemp &&
        other.maxWindSpeed == maxWindSpeed &&
        other.chanceOfRain == chanceOfRain &&
        other.totalPrecipitation == totalPrecipitation &&
        other.weatherCondition == weatherCondition &&
        other.uv == uv;
  }

  @override
  int get hashCode {
    return maxTemp.hashCode ^
        minTemp.hashCode ^
        avgTemp.hashCode ^
        maxWindSpeed.hashCode ^
        chanceOfRain.hashCode ^
        totalPrecipitation.hashCode ^
        weatherCondition.hashCode ^
        uv.hashCode;
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonPhase;
  final int isSunUp;
  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
    required this.isSunUp,
  });

  Astro copyWith({
    String? sunrise,
    String? sunset,
    String? moonPhase,
    int? isSunUp,
  }) {
    return Astro(
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonPhase: moonPhase ?? this.moonPhase,
      isSunUp: isSunUp ?? this.isSunUp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sunrise': sunrise,
      'sunset': sunset,
      'moon_phase': moonPhase,
      'is_sun_up': isSunUp,
    };
  }

  factory Astro.fromMap(Map<String, dynamic> map) {
    return Astro(
      sunrise: map['sunrise'] as String,
      sunset: map['sunset'] as String,
      moonPhase: map['moon_phase'] as String,
      isSunUp: map['is_sun_up'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Astro.fromJson(String source) =>
      Astro.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Astro(sunrise: $sunrise, sunset: $sunset, moonPhase: $moonPhase, isSunUp: $isSunUp)';
  }

  @override
  bool operator ==(covariant Astro other) {
    if (identical(this, other)) return true;

    return other.sunrise == sunrise &&
        other.sunset == sunset &&
        other.moonPhase == moonPhase &&
        other.isSunUp == isSunUp;
  }

  @override
  int get hashCode {
    return sunrise.hashCode ^
        sunset.hashCode ^
        moonPhase.hashCode ^
        isSunUp.hashCode;
  }
}

class ForecastDay {
  final DateTime date;
  final Day day;
  final Astro astro;
  ForecastDay({required this.date, required this.day, required this.astro});

  ForecastDay copyWith({DateTime? date, Day? day, Astro? astro}) {
    return ForecastDay(
        date: date ?? this.date,
        day: day ?? this.day,
        astro: astro ?? this.astro);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'day': day.toMap(),
    };
  }

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    return ForecastDay(
      date: DateTime.fromMillisecondsSinceEpoch(
          // converting seconds to milliseconds
          (map['date_epoch'] as int) * 1000),
      day: Day.fromMap(map['day'] as Map<String, dynamic>),
      astro: Astro.fromMap(map['astro'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDay.fromJson(String source) =>
      ForecastDay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForecastDay(date: $date, day: $day)';

  @override
  bool operator ==(covariant ForecastDay other) {
    if (identical(this, other)) return true;

    return other.date == date && other.day == day;
  }

  @override
  int get hashCode => date.hashCode ^ day.hashCode;
}

class Forecast {
  final List<ForecastDay> forecastday;
  Forecast({
    required this.forecastday,
  });

  Forecast copyWith({
    List<ForecastDay>? forecastday,
  }) {
    return Forecast(
      forecastday: forecastday ?? this.forecastday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'forecastday': forecastday.map((x) => x.toMap()).toList(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      forecastday: List<ForecastDay>.from(
        (map['forecastday'] as List<dynamic>).map<ForecastDay>(
          (x) => ForecastDay.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Forecast(forecastday: $forecastday)';

  @override
  bool operator ==(covariant Forecast other) {
    if (identical(this, other)) return true;

    return listEquals(other.forecastday, forecastday);
  }

  @override
  int get hashCode => forecastday.hashCode;
}
