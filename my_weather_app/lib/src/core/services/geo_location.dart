import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather_app/src/core/error/exception.dart';

class GeoLocation {
  /// GeoLocation class contains the methods to access location services
  Future<String> getLocationCurrent() async {
    // function to get current location
    debugPrint("Getting current location");

    try {
      final Position locationData = await Geolocator.getCurrentPosition();
      final String currentLocation =
          "${locationData.latitude},${locationData.longitude}";
      return currentLocation;
    } catch (e) {
      throw ServerException(e);
    }
  }

  Future<bool> checkLocationPermission() async {
    // function to check wether the device have location permission returns true if there is location permission
    final permission = await Geolocator.checkPermission();
    debugPrint("Location permission Status : $permission");
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<bool> checkIfLocationEnabled() async {
    // function to check if location is enabled in the device returns true if enabled

    final isEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint("Location Enabled Status : $isEnabled");
    return isEnabled;
  }

  Future<bool> requestPermission() async {
    // function to request permission and location service for location returns true if granted
    final bool isLocationEnabled = await checkIfLocationEnabled();
    if (!isLocationEnabled) {
      final bool locationEnabled = await Geolocator.openLocationSettings();
      if (!locationEnabled) {
        return false;
      }
    }
    final isPermissionGranted = await checkLocationPermission();
    if (!isPermissionGranted) {
      final permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.always ||
          permissionGranted == LocationPermission.whileInUse) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
}
