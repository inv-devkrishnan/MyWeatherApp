import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/location_change/domain/models/favorite_location_model.dart';
import 'package:my_weather_app/src/features/location_change/presentation/provider/favorite_provider.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/location_provider.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/network_check_profile.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/error.dart';

class BottomCardSheet extends ConsumerStatefulWidget {
  final Size size;
  const BottomCardSheet(this.size, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomCardSheetState();
}

class _BottomCardSheetState extends ConsumerState<BottomCardSheet> {
  @override
  Widget build(BuildContext context) {
    final network = ref.watch(networkCheckProvider);
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      color: Colors.transparent,
      child: network
          ? Column(
              children: [
                SizedBox(
                  height: widget.size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: widget.size.width,
                      child: const AutoSizeText(
                        "Favorites",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.size.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ref.watch(favoriteListProvider).when(
                              data: (data) => data.isEmpty
                                  ? const Center(
                                      child: Text("No favorites"),
                                    )
                                  : SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        child: Wrap(
                                          children: [
                                            for (FavoriteLocation item in data)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 0),
                                                child: InputChip(
                                                  label:
                                                      Text(item.locationName),
                                                  onPressed: item.deleted
                                                      ? () => Fluttertoast.showToast(
                                                          msg:
                                                              "This location is currently unavailable",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: AppColors
                                                              .primaryTextColor,
                                                          textColor: AppColors
                                                              .primaryColor,
                                                          fontSize: 16.0)
                                                      : () {
                                                          ref
                                                                  .read(placeProvider
                                                                      .notifier)
                                                                  .state =
                                                              item.locationName;
                                                          context.maybePop();
                                                        },
                                                  onDeleted: () => {
                                                    ref
                                                        .read(
                                                            favoriteControllerProvider
                                                                .notifier)
                                                        .removefromFavorite(
                                                            context,
                                                            item.locationName)
                                                  },
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                              loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryTextColor,
                                ),
                              ),
                              error: (error, stackTrace) => ErrorMessage(
                                errorString: error.toString(),
                                callback: () =>
                                    ref.invalidate(favoriteListProvider),
                              ),
                            ),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            context.maybePop();
                            AutoRouter.of(context)
                                .push(const SetLocationRoute());
                          },
                          child: const Text("Choose other locations")),
                    ],
                  ),
                )
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_outlined,
                    color: AppColors.primaryTextColor,
                    size: 42,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: AutoSizeText(
                      "You are currently offline",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  AutoSizeText(
                    "Please try again when your online",
                  ),
                ],
              ),
            ),
    );
  }
}
