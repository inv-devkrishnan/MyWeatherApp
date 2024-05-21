// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_condition_model.dart';

class CurrentWeather {
  final DateTime lastUpdated;
  final double temp;
  final WeatherCondition weatherCondition;
  final double windSpeed;
  final String windDirection;
  final double precipitation;
  final double feelsLike;
  final double uv;
  CurrentWeather({
    required this.lastUpdated,
    required this.temp,
    required this.weatherCondition,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitation,
    required this.feelsLike,
    required this.uv,
  });

  CurrentWeather copyWith({
    DateTime? lastUpdated,
    double? temp,
    WeatherCondition? weatherCondition,
    double? windSpeed,
    String? windDirection,
    double? precipitation,
    double? feelsLike,
    double? uv,
  }) {
    return CurrentWeather(
      lastUpdated: lastUpdated ?? this.lastUpdated,
      temp: temp ?? this.temp,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      precipitation: precipitation ?? this.precipitation,
      feelsLike: feelsLike ?? this.feelsLike,
      uv: uv ?? this.uv,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
      'temp': temp,
      'weatherCondition': weatherCondition.toMap(),
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'percipitation': precipitation,
      'feelsLike': feelsLike,
      'uv': uv,
    };
  }

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          (map['last_updated_epoch'] as int) * 1000),
      temp: map['temp_c'] as double,
      weatherCondition:
          WeatherCondition.fromMap(map['condition'] as Map<String, dynamic>),
      windSpeed: map['wind_kph'] as double,
      windDirection: map['wind_dir'] as String,
      precipitation: map['precip_mm'] as double,
      feelsLike: map['feelslike_c'] as double,
      uv: map['uv'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJson(String source) =>
      CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentWeatherModel(lastUpdated: $lastUpdated, temp: $temp, weatherCondition: $weatherCondition, windSpeed: $windSpeed, windDirection: $windDirection, percipitation: $precipitation, feelsLike: $feelsLike, uv: $uv)';
  }

  @override
  bool operator ==(covariant CurrentWeather other) {
    if (identical(this, other)) return true;

    return other.lastUpdated == lastUpdated &&
        other.temp == temp &&
        other.weatherCondition == weatherCondition &&
        other.windSpeed == windSpeed &&
        other.windDirection == windDirection &&
        other.precipitation == precipitation &&
        other.feelsLike == feelsLike &&
        other.uv == uv;
  }

  @override
  int get hashCode {
    return lastUpdated.hashCode ^
        temp.hashCode ^
        weatherCondition.hashCode ^
        windSpeed.hashCode ^
        windDirection.hashCode ^
        precipitation.hashCode ^
        feelsLike.hashCode ^
        uv.hashCode;
  }
}
