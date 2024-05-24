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
  await InitDependencies.initFirebase();
  db = await DatabaseHelper.instance.database;
  InitDependencies.setDeviceOrientation();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
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
