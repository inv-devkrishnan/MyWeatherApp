import 'package:my_weather_app/src/features/location_change/domain/models/favorite_location_model.dart';

abstract interface class FavoritesRespository {
  Future<void> addToFavorites(String locationName);
  Future<void> deleteFromFavorites(String locationName);
  Future<List<String>> getAllFavorties();
  Future<List<FavoriteLocation>> getFavorites();
}
