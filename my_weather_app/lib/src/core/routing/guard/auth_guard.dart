import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/location/geo_location.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  // implementation of authguard in weatherapp
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    debugPrint("inside authguard");
    Authentication auth = Authentication(FirebaseAuth.instance);
    GeoLocation permission = GeoLocation(Location());
    if (!auth.isUserLoggedIn()) {
      debugPrint("User is not logged in redirecting to login page");
      router.popAndPush(const LoginRoute());
    } else if (!await permission.checkLocationPermission() ||
        !await permission.checkIfLocationEnabled()) {
      debugPrint(
          "User hasn't given location permission redirecting to permission page");
      router.popAndPush(const PermissionRoute());
    } else {
      debugPrint("Normal routing flow achieved");
      resolver.next(true); // normal flow
      router.removeLast();
    }
  }
}
