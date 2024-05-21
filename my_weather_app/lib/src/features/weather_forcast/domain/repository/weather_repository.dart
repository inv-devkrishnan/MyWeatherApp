import 'package:my_weather_app/src/features/weather_forcast/domain/models/weather_data_model.dart';

abstract interface class WeatherRepository {
  Future<WeatherData> getCurrentWeather(String? location);
}
