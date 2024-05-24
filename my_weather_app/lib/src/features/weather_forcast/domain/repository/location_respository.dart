import 'package:my_weather_app/src/features/weather_forcast/domain/models/location_list_model.dart';

abstract interface class LocationRespository {
  Future<LocationList> getLocationList();
}
