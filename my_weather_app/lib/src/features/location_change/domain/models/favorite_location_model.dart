// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteLocation {
  String locationName;
  bool deleted;
  FavoriteLocation({
    required this.locationName,
    required this.deleted,
  });

  FavoriteLocation copyWith({
    String? locationName,
    bool? deleted,
  }) {
    return FavoriteLocation(
      locationName: locationName ?? this.locationName,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationName': locationName,
      'deleted': deleted,
    };
  }

  factory FavoriteLocation.fromMap(Map<String, dynamic> map) {
    return FavoriteLocation(
      locationName: map['locationName'] as String,
      deleted: map['deleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteLocation.fromJson(String source) =>
      FavoriteLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavoriteLocationModel(locationName: $locationName, deleted: $deleted)';

  @override
  bool operator ==(covariant FavoriteLocation other) {
    if (identical(this, other)) return true;

    return other.locationName == locationName && other.deleted == deleted;
  }

  @override
  int get hashCode => locationName.hashCode ^ deleted.hashCode;
}
