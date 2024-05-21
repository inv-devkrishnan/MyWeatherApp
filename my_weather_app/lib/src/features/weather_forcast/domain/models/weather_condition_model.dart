// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherCondition {
  final String text;
  final String icon;
  WeatherCondition({
    required this.text,
    required this.icon,
  });

  WeatherCondition copyWith({
    String? text,
    String? icon,
  }) {
    return WeatherCondition(
      text: text ?? this.text,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'icon': icon,
    };
  }

  factory WeatherCondition.fromMap(Map<String, dynamic> map) {
    return WeatherCondition(
      text: map['text'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherCondition.fromJson(String source) =>
      WeatherCondition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherCondition(text: $text, icon: $icon)';

  @override
  bool operator ==(covariant WeatherCondition other) {
    if (identical(this, other)) return true;

    return other.text == text && other.icon == icon;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode;
}
