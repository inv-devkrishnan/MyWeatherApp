import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> exitApp() async {
  // function which helps to exit the application
  try {
    if (Platform.isAndroid) {
      // android implementation
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      // ios implementation
      exit(0);
    }
  } on PlatformException catch (err) {
    // Handle potential errors (e.g., the app may already be at the root)
    debugPrint("Error exiting app: $err");
  }
}
