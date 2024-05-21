import 'package:flutter/foundation.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/core/location/geo_location.dart';
import 'package:my_weather_app/src/core/secrets/api_keys.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;
  final GeoLocation geoLocation;
  WeatherRepositoryImpl(this.dio, this.geoLocation);
  @override
  Future<WeatherData> getCurrentWeather(String? location) async {
    /*Function to get current weather data accepts location name and null value
    if value is null current location is considered
   */

    late final String currentLocation;
    if (location == null) {
      currentLocation = await geoLocation.getCurrentLocation();
    } else {
      currentLocation = location;
    }
    try {
      final response = await dio
          .get("https://api.weatherapi.com/v1/forecast.json", queryParameters: {
        "key": weatherAPIkey,
        "q": currentLocation,
        "days": 4
      });
      debugPrint("Weather api call recieved on ${response.headers["Date"]}");
      return WeatherData.fromMap(response.data);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e);
    }
  }
}
