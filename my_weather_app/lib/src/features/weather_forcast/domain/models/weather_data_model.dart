// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/current_weather_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_forcast_day_model.dart';

class WeatherData {
  final WeatherLocation location;
  final CurrentWeather current;
  final Forecast forecast;
  WeatherData({
    required this.location,
    required this.current,
    required this.forecast,
  });

  WeatherData copyWith({
    WeatherLocation? location,
    CurrentWeather? current,
    Forecast? forecast,
  }) {
    return WeatherData(
      location: location ?? this.location,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'current': current.toMap(),
      'forecast': forecast.toMap(),
    };
  }

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      location:
          WeatherLocation.fromMap(map['location'] as Map<String, dynamic>),
      current: CurrentWeather.fromMap(map['current'] as Map<String, dynamic>),
      forecast: Forecast.fromMap(map['forecast'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherData.fromJson(String source) =>
      WeatherData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeatherData(location: $location, current: $current, forecast: $forecast)';

  @override
  bool operator ==(covariant WeatherData other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.current == current &&
        other.forecast == forecast;
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode ^ forecast.hashCode;
}
