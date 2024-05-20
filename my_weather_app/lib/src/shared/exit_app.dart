import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> exitApp() async {
  try {
    if (Platform.isAndroid) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      exit(0);
    }
  } on PlatformException catch (err) {
    // Handle potential errors (e.g., the app may already be at the root)
    debugPrint("Error exiting app: $err");
  }
}
