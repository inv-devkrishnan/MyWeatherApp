import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  // implementation of authguard in weatherapp
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    debugPrint("inside authguard");
    Authentication auth = Authentication(FirebaseAuth.instance);
    if (!auth.isUserLoggedIn()) {
      debugPrint("User is not logged in redirecting to login page");
      router.popAndPush(const LoginRoute());
    } else {
      debugPrint("Normal routing flow achieved");
      resolver.next(true); // normal flow
      router.removeLast();
    }
  }
}
