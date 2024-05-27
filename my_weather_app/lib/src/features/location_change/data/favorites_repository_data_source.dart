import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/core/services/db_helper.dart';
import 'package:my_weather_app/src/features/location_change/domain/favorites_repository.dart';
import 'package:my_weather_app/src/features/location_change/domain/models/favorite_location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/init_dependencies.dart';
import '../../weather_forcast/domain/models/location_list_model.dart';

class FavoritesRepositoryImpl implements FavoritesRespository {
  final Database db;
  final Authentication auth;
  final Dio dio;
  FavoritesRepositoryImpl(this.db, this.auth, this.dio);

  @override
  Future<void> addToFavorites(String locationName) async {
    // function add locations to favorites list
    try {
      String? uid = auth.currentUserId();
      if (uid != null) {
        await db.insert(
          DatabaseHelper.favoritesTable,
          {
            DatabaseHelper.userId: uid,
            DatabaseHelper.locationName: locationName
          },
        );
        debugPrint("$locationName added to favoritesTable");
      } else {
        throw Exception("User id got null");
      }
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<List<String>> getAllFavorties() async {
    List<String> locationList = [];
    try {
      String? uid = auth.currentUserId();
      if (uid != null) {
        final List<Map<String, dynamic>> data = await db.query(
            DatabaseHelper.favoritesTable,
            columns: [DatabaseHelper.locationName],
            where: '${DatabaseHelper.userId} = ?',
            whereArgs: [uid]);
        for (Map<String, dynamic> item in data) {
          locationList.add(item[DatabaseHelper.locationName]);
        }
        return locationList;
      } else {
        throw Exception("User id got null");
      }
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<List<FavoriteLocation>> getFavorites() async {
    List<String> locationList;
    List<String> allFavorites;
    List<FavoriteLocation> list = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      String? response = prefs.getString("location_list");
      if (response == null) {
        debugPrint("location list is empty trying fetch again");
        response = await InitDependencies(dio).initLocationList();
      }
      locationList = LocationList.fromMap(jsonDecode(response!)).places;
      allFavorites = await getAllFavorties();
      for (String item in allFavorites) {
        list.add(FavoriteLocation(
            locationName: item, deleted: !locationList.contains(item)));
      }
      return list;
    } catch (e) {
      throw ServerException(e);
    }
  }

  @override
  Future<void> deleteFromFavorites(String locationName) async {
    try {
      String? uid = auth.currentUserId();
      if (uid != null) {
        await db.delete(DatabaseHelper.favoritesTable,
            where:
                '${DatabaseHelper.userId} = ? AND ${DatabaseHelper.locationName} = ?',
            whereArgs: [uid, locationName]);
        debugPrint("$locationName removed from favoritesTable");
      } else {
        throw Exception("User id got null");
      }
    } catch (e) {
      throw ServerException(e);
    }
  }
}
