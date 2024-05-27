import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/features/location_change/presentation/provider/favorite_provider.dart';

import '../../../../core/theme/app_colors.dart';

class FavBtn extends ConsumerStatefulWidget {
  final String locationName;
  const FavBtn(this.locationName, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavBtnState();
}

class _FavBtnState extends ConsumerState<FavBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.favorite_border_rounded,
          color: AppColors.primaryTextColor,
        ),
        onPressed: () {
          ref
              .read(favoriteControllerProvider.notifier)
              .addToFavorite(context, widget.locationName);
          ref.invalidate(favoriteListProvider);
        });
  }
}
