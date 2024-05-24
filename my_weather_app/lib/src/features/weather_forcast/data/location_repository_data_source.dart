import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_list_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/repository/location_respository.dart';

class LocationRepositoryImpl implements LocationRespository {
  final Dio dio;

  LocationRepositoryImpl(this.dio);

  @override
  Future<LocationList> getLocationList() async {
    try {
      Response response = await dio.get(locationListURL);
      debugPrint("Fetched location list");
      return LocationList.fromMap(response.data);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e);
    }
  }
}
