import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather_app/firebase_options.dart';
import 'package:my_weather_app/src/core/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitDependencies {
  final Dio dio;
  InitDependencies(this.dio);
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static void setDeviceOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<dynamic> initLocationList() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Response res = await dio.get(locationListURL);
      sharedPreferences.setString("location_list", jsonEncode(res.data));
      debugPrint("fetched location list");
      return jsonEncode(res.data);
    } catch (e) {
      debugPrint(
          "WARNING !! : Couldn't fetch location list device maybe offline");
    }
  }
}
