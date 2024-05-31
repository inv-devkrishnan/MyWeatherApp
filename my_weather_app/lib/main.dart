import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/init_dependencies.dart';
import 'package:my_weather_app/src/core/routing/app_router.dart';
import 'package:my_weather_app/src/core/services/db_helper.dart';
import 'package:my_weather_app/src/core/theme/text_scaler.dart';
import 'package:my_weather_app/src/core/theme/theme.dart';
import 'package:sqflite/sqflite.dart';

import 'src/core/globals/global_keys.dart';

late final Database? db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitDependencies.initFirebase(); // initialize firebase auth
  db = await DatabaseHelper.instance.database; // initialize db
  // InitDependencies.setDeviceOrientation(); // sets device orientation
  InitDependencies(Dio()).initLocationList(); // gets location list
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static bool isAppPaused = false;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
        routerConfig: appRouter.config(),
        scaffoldMessengerKey: scaffoldkey,
        title: 'MyWeatherApp',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().appTheme(context),
        builder: (context, child) => UIScaler().textScaler(context, child));
  }
}
