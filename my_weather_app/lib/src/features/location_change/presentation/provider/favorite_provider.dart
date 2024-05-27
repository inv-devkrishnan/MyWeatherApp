import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/main.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/core/theme/theme.dart';
import 'package:my_weather_app/src/features/location_change/data/favorites_repository_data_source.dart';
import 'package:my_weather_app/src/features/location_change/domain/favorites_repository.dart';
import 'package:my_weather_app/src/features/location_change/domain/models/favorite_location_model.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/location_list_provider.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/location_provider.dart';

import '../../../../core/globals/global_keys.dart';

final favoritesProvider = Provider<FavoritesRespository>((ref) {
  return FavoritesRepositoryImpl(
      db!, Authentication(FirebaseAuth.instance), Dio());
});

final favoriteListProvider = FutureProvider<List<FavoriteLocation>>((ref) {
  return FavoritesRepositoryImpl(
          db!, Authentication(FirebaseAuth.instance), Dio())
      .getFavorites();
});

class FavoriteController extends StateNotifier<AsyncValue<void>> {
  FavoriteController(this.ref)
      // set the initial state
      : super(const AsyncData(null));
  final Ref ref;

  Future<void> addToFavorite(BuildContext context, String locationName) async {
    // read the repository using ref
    final favoriteRepository = ref.read(favoritesProvider);
    // set the loading state
    state = const AsyncLoading();
    // update the state (data or error)
    state = await AsyncValue.guard(
        () => favoriteRepository.addToFavorites(locationName));
    if (context.mounted && !state.hasError) {
      ref.read(placeProvider.notifier).state = locationName;
      context.maybePop();
      ref.invalidate(locationListProvider);
      scaffoldkey.currentState!.showSnackBar(
        SnackBar(
          content: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                "$locationName added to favorties",
                style: const TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: AppColors.successColor,
        ),
      );
    } else if (context.mounted && state.hasError) {
      // if state ends up in error
      scaffoldkey.currentState!.showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  Future<void> removefromFavorite(
      BuildContext context, String locationName) async {
    // read the repository using ref
    final favoriteRepository = ref.read(favoritesProvider);
    // set the loading state
    state = const AsyncLoading();
    // update the state (data or error)
    state = await AsyncValue.guard(
        () => favoriteRepository.deleteFromFavorites(locationName));
    if (context.mounted && !state.hasError) {
      ref.invalidate(favoriteListProvider);
      ref.invalidate(locationListProvider);
      context.maybePop();
      scaffoldkey.currentState!.showSnackBar(
        SnackBar(
          content: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child:
                    Icon(Icons.heart_broken, color: AppColors.primaryTextColor),
              ),
              AutoSizeText(
                "$locationName removed from favorties",
                style: AppTheme.snackbarStyle(),
                maxLines: 3,
              ),
            ],
          ),
          backgroundColor: AppColors.errorColor,
        ),
      );
    } else if (context.mounted && !state.hasError) {
      // if state ends up in error
      scaffoldkey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            state.error.toString(),
            style: AppTheme.snackbarStyle(),
          ),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }
}

final favoriteControllerProvider =
    StateNotifierProvider<FavoriteController, AsyncValue<void>>((ref) {
  return FavoriteController(ref);
});
