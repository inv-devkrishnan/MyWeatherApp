// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherCondition {
  final String text;
  final String icon;
  final int code;
  WeatherCondition({
    required this.text,
    required this.icon,
    required this.code,
  });

  WeatherCondition copyWith({
    String? text,
    String? icon,
    int? code,
  }) {
    return WeatherCondition(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  factory WeatherCondition.fromMap(Map<String, dynamic> map) {
    return WeatherCondition(
      text: map['text'] as String,
      icon: map['icon'] as String,
      code: map['code'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherCondition.fromJson(String source) =>
      WeatherCondition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeatherCondition(text: $text, icon: $icon, code: $code)';

  @override
  bool operator ==(covariant WeatherCondition other) {
    if (identical(this, other)) return true;

    return other.text == text && other.icon == icon && other.code == code;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode ^ code.hashCode;
}
