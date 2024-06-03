import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/firebase_options.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:my_weather_app/src/core/services/date_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitDependencies {
  final Dio dio;
  InitDependencies(this.dio);
  static Future<void> initFirebase() async {
    // function to initialize firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // static void setDeviceOrientation() async {

  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]);
  // }

  Future<dynamic> initLocationList() async {
    // function to fetch and update location list
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int? previouseFetchedTime =
          sharedPreferences.getInt("location_list_updated_date");
      if (previouseFetchedTime == null ||
          DateFormatter.isPastOneDay(previouseFetchedTime)) {
        Response res = await dio.get(locationListURL);
        sharedPreferences.setString("location_list", jsonEncode(res.data));
        sharedPreferences.setInt("location_list_updated_date",
            DateTime.now().millisecondsSinceEpoch);
        debugPrint("Fetched location list");
        return jsonEncode(res.data);
      }
    } catch (e) {
      debugPrint(
          "WARNING !! : Couldn't fetch location list device maybe offline");
    }
  }
}
