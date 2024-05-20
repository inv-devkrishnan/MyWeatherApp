import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPermission {
  final Location location;
  LocationPermission(this.location);
  Future<bool> checkLocationPermission() async {
    // function to check wether the device have location permission returns true if there is location permission
    final permission = await location.hasPermission();
    debugPrint("Location permission Status : $permission");
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever) {
      return false;
    } else if (permission == PermissionStatus.grantedLimited ||
        permission == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> checkIfLocationEnabled() async {
    // function to check if location is enabled in the device returns true if enabled

    final isEnabled = await location.serviceEnabled();
    debugPrint("Location Enabled Status : $isEnabled");
    return isEnabled;
  }

  Future<bool> requestPermission() async {
    // function to request permission and location service for location returns true if granted
    final bool isLocationEnabled = await checkIfLocationEnabled();
    if (!isLocationEnabled) {
      final bool locationEnabled = await location.requestService();
      if (!locationEnabled) {
        return false;
      }
    }
    final isPermissionGranted = await checkLocationPermission();
    if (!isPermissionGranted) {
      final permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
}
