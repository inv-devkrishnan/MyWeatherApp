// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherLocation {
  final String name;
  final String region;
  final String country;
  WeatherLocation({
    required this.name,
    required this.region,
    required this.country,
  });

  WeatherLocation copyWith({
    String? name,
    String? region,
    String? country,
  }) {
    return WeatherLocation(
      name: name ?? this.name,
      region: region ?? this.region,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'region': region,
      'country': country,
    };
  }

  factory WeatherLocation.fromMap(Map<String, dynamic> map) {
    return WeatherLocation(
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherLocation.fromJson(String source) =>
      WeatherLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LocationModel(name: $name, region: $region, country: $country)';

  @override
  bool operator ==(covariant WeatherLocation other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.region == region &&
        other.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ region.hashCode ^ country.hashCode;
}
