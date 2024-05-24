import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final placeProvider = StateProvider<String>((ref) {
  debugPrint("place provider called");
  return ':loc'; // Default initial location
});
