import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:my_weather_app/src/core/services/geo_location.dart';
import 'package:my_weather_app/src/features/weather_forcast/data/weather_repository_data_source.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';

final weatherProvider =
    FutureProvider.family.autoDispose<WeatherData, String?>((ref, location) {
  Timer(updateDuration, () {
    debugPrint("Auto Refresh called");
    ref.invalidateSelf();
  });
  return WeatherRepositoryImpl(
    Dio(),
    GeoLocation(Location()),
  ).getCurrentWeather(location);
});