import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/core/init_dependencies.dart';
import 'package:my_weather_app/src/features/location_change/data/favorites_repository_data_source.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_list_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/domain/repository/location_respository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocationRepositoryImpl implements LocationRespository {
  final Dio dio;
  final Database db;
  final Authentication auth;
  final SharedPreferences sharedPreferences;

  LocationRepositoryImpl(this.dio, this.db, this.auth, this.sharedPreferences);

  @override
  Future<LocationList> getLocationList() async {
    LocationList locationList;

    try {
      String? response = sharedPreferences.getString("location_list");
      if (response == null) {
        debugPrint("location list is empty trying fetch again");
        response = await InitDependencies(dio).initLocationList();
      }
      locationList = LocationList.fromMap(jsonDecode(response!));
      List<String> favLocationList =
          await FavoritesRepositoryImpl(db, auth, dio).getAllFavorties();
      List<String> otherlocationsList = locationList.places;
      otherlocationsList
          .removeWhere((location) => favLocationList.contains(location));

      LocationList newList = LocationList(places: otherlocationsList);
      return newList;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e);
    }
  }
}
