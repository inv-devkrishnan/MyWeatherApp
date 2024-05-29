import 'package:hooks_riverpod/hooks_riverpod.dart';

final networkCheckProvider = StateProvider<bool>((ref) {
  return true; // Default initial location
});
