import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/main.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/features/weather_forcast/data/location_repository_data_source.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locationListProvider = FutureProvider<LocationList>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return LocationRepositoryImpl(
          Dio(), db!, Authentication(FirebaseAuth.instance), sharedPreferences)
      .getLocationList();
});
