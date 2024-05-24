import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/features/weather_forcast/data/location_repository_data_source.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_list_model.dart';

final locationListProvider = FutureProvider<LocationList>((ref) {
  return LocationRepositoryImpl(Dio()).getLocationList();
});
