import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/main.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:my_weather_app/src/core/services/geo_location.dart';
import 'package:my_weather_app/src/features/weather_forcast/data/weather_repository_data_source.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final weatherProvider =
//     FutureProvider.family.autoDispose<WeatherData, String?>((ref, location) {
//   Timer(updateDuration, () {
//     debugPrint("Auto Refresh called");
//     ref.invalidateSelf();
//   });
//   return WeatherRepositoryImpl(
//     Dio(),
//     GeoLocation(Location()),
//   ).getCurrentWeather(location);
// });

// final weatherProvider =
//     StreamProvider.family.autoDispose<WeatherData, String?>((ref, location) {
//   // Stream that emits new weather data periodically
//   Stream<WeatherData> weatherStream() async* {
//     while (true) {
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         final weatherData =
//             await WeatherRepositoryImpl(Dio(), GeoLocation(), prefs)
//                 .getCurrentWeather(location);
//         yield weatherData;
//       } catch (e) {
//         // Handle error appropriately
//         yield* Stream.error(e);
//       }
//       await Future.delayed(updateDuration); // emits according to updateDuration
//     }
//   }

//   return weatherStream();
// });

final weatherProvider =
    StreamProvider.family.autoDispose<WeatherData, String?>((ref, location) {
  final streamController = StreamController<WeatherData>();

  void startStream() async {
    while (!streamController.isClosed && !MyApp.isAppPaused) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final weatherData =
            await WeatherRepositoryImpl(Dio(), GeoLocation(), prefs)
                .getCurrentWeather(location);
        streamController.add(weatherData);
      } catch (e) {
        if (e is StateError) {
          debugPrint(
              "State Error Occured"); // handling state error which occur's when autorefresh and change location called simulataniously
        } else {
          streamController.addError(e);
        }
      }
      await Future.delayed(updateDuration);
    }
  }

  ref.onDispose(() {
    streamController.close();
  });

  startStream();
  return streamController.stream;
});
