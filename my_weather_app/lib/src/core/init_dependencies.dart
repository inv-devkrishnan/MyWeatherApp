import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:my_weather_app/firebase_options.dart';

class InitDependencies {
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

  // static Future<void> initLocationList() async {
  //   try {
  //     LocationList list = await LocationRepositoryImpl(Dio()).getLocationList();

  //     debugPrint(list.toMap().toString());
  //   } on ServerException {
  //     debugPrint("Couldn't get locationList");
  //   } on Exception catch (e) {
  //     debugPrint("ERROR !! occcured in initLocationList list Reason : $e");
  //   }
  // }
}
