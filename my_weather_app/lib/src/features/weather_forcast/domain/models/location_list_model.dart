// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LocationList {
  final List<String> places;
  LocationList({
    required this.places,
  });

  LocationList copyWith({
    List<String>? places,
  }) {
    return LocationList(
      places: places ?? this.places,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location_name': places,
    };
  }

  factory LocationList.fromMap(Map<String, dynamic> map) {
    return LocationList(
        places: List<String>.from(
      (map['places'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory LocationList.fromJson(String source) =>
      LocationList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationList(places: $places)';

  @override
  bool operator ==(covariant LocationList other) {
    if (identical(this, other)) return true;

    return listEquals(other.places, places);
  }

  @override
  int get hashCode => places.hashCode;
}
