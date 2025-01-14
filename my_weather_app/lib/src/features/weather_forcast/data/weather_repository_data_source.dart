import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/core/services/geo_location.dart';
import 'package:my_weather_app/src/core/secrets/api_keys.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;
  final GeoLocation geoLocation;
  final SharedPreferences prefs;
  WeatherRepositoryImpl(this.dio, this.geoLocation, this.prefs);
  @override
  Future<WeatherData> getCurrentWeather(String? location) async {
    /*Function to get current weather data accepts location name and null value
    if value is null current location is considered
   */
    try {
      if (await InternetConnection().hasInternetAccess) {
        late final String currentLocation;

        if (location == null || location == ":loc") {
          // if location is null gets the GPS location
          currentLocation = await geoLocation.getLocationCurrent();
        } else {
          debugPrint("set Location : $location");
          currentLocation = location;
        }

        // api response
        final response = await dio.get(weatherAPIURL, queryParameters: {
          "key": weatherAPIkey,
          "q": currentLocation,
          "days": 3
        });

        debugPrint("Weather api call recieved on ${response.headers["Date"]}");

        // caches weather data for offline use;
        await prefs.setString('weather_cache', jsonEncode(response.data));

        return WeatherData.fromMap(response.data);
      } else {
        // gets previous data from cache
        final String? cachedData = prefs.getString("weather_cache");
        if (cachedData != null) {
          debugPrint(
              "Connection to server failed ! returning cached weather data");
          return WeatherData.fromMap(jsonDecode(cachedData));
        } else {
          // if cache is empty throw Exception
          throw Exception("Network offline and Cache Empty");
        }
      }
    } catch (e) {
      throw ServerException(e);
    }
  }
}
