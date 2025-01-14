import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_weather_app/main.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/network_check_profile.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/weather_provider.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/service/weather_image.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/background_image.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/change_location_btn.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/current_weather.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/error.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/future_weather_tile.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/hourly_forcast_chart.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/loading.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/logout_btn.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/sub_heading.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/weather_info_blocks.dart';

import '../../../../core/globals/global_keys.dart';
import '../providers/location_provider.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  final String? loc;
  const HomePage({super.key, @PathParam('loc') this.loc});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final AppLifecycleListener _listener;
  late final StreamSubscription<InternetStatus> listener;

  String? loadLocation;
  @override
  void initState() {
    super.initState();
    loadLocation = widget.loc;
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );

    listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.disconnected) {
        // sets the provider value
        ref.read(networkCheckProvider.notifier).state = false;
        // shows the snabar for no network
        showOfflineSnackBar();
      } else if (status == InternetStatus.connected) {
        // if connected sets provider true again
        ref.read(networkCheckProvider.notifier).state = true;
      }
    });
  }

  @override
  void dispose() {
    _listener.dispose();
    listener.cancel();

    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    // execute when app state changes
    debugPrint("current app state : ${state.name}");
    if (state == AppLifecycleState.paused) {
      MyApp.isAppPaused = true; // sets pause global variable true
    }
    if (state == AppLifecycleState.resumed && MyApp.isAppPaused) {
      _onResumed();
      MyApp.isAppPaused = false;
    }
  }

  void _onResumed() {
    // once app is resumed from background reload the provider
    ref.invalidate(weatherProvider);
  }

  ScaffoldFeatureController showOfflineSnackBar() {
    scaffoldkey.currentState!.clearSnackBars();
    return scaffoldkey.currentState!.showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Icon(
                Icons.wifi_off_outlined,
                color: AppColors.primaryTextColor,
              ),
            ),
            Text("You are offline, Showing outdated data"),
          ],
        ),
        backgroundColor: AppColors.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String place = ref.watch(placeProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ResponsiveSafeArea(
          builder: (context, size) => ref.watch(weatherProvider(place)).when(
                skipLoadingOnRefresh: false,
                data: (data) {
                  return Stack(children: [
                    BackgroundImage(
                      backgroundImagePath: WeatherImage.getWeatherImage(
                          data.current.weatherCondition.code),
                    ),
                    RefreshIndicator(
                      backgroundColor: AppColors.primaryColor,
                      color: AppColors.primaryTextColor,
                      onRefresh: ref.watch(networkCheckProvider)
                          ? () => ref.refresh(weatherProvider(place).future)
                          : () async => showOfflineSnackBar(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ChangeLocationBtn(
                                  size: size,
                                ),
                                const LogoutBtn(),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(size.width * 0.05,
                                  size.height * 0.02, size.width * 0.05, 0),
                              child: CurrentWeather(size: size, data: data),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(size.width * 0.05,
                                  size.height * 0.02, size.width * 0.05, 0),
                              child: SubHeading(
                                  size: size, heading: "Today's Forecast"),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.05,
                                  size.height * 0.02,
                                  size.width * 0.05,
                                  size.height * 0.02),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryTransColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: AutoSizeText(
                                        "Hourly Forcast",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      width: size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            width: 1500,
                                            child: HourlyForcastChart(
                                                hourData: data.forecast
                                                    .forecastday[0].hour),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.02),
                              child: SizedBox(
                                width: size.width,
                                height: 120,
                                child: Center(
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath: "assets/images/wind.svg",
                                          heading: "Wind",
                                          body:
                                              "${data.current.windSpeed} km/h , ${data.current.windDirection}"),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath:
                                              "assets/images/precipitation.svg",
                                          heading: "Precipitation",
                                          body:
                                              "${data.current.precipitation} mm"),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath:
                                              "assets/images/uv_index.svg",
                                          heading: "UV Index",
                                          body: "${data.current.uv}"),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath: "assets/images/rain.svg",
                                          heading: "Chance of rain",
                                          body:
                                              "${data.forecast.forecastday[0].day.chanceOfRain} %"),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath:
                                              "assets/images/sun_rise.svg",
                                          heading: "Sunrise",
                                          body: data.forecast.forecastday[0]
                                              .astro.sunrise),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath:
                                              "assets/images/sun_set.svg",
                                          heading: "Sunset",
                                          body: data.forecast.forecastday[0]
                                              .astro.sunset),
                                      WeatherInfoBlocks(
                                          size: size,
                                          imagePath:
                                              "assets/images/moon_phase.svg",
                                          heading: "Moon Phase",
                                          body: data.forecast.forecastday[0]
                                              .astro.moonPhase),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(size.width * 0.05,
                                  size.height * 0.02, size.width * 0.05, 0),
                              child: SubHeading(
                                  size: size, heading: "Future Forecast"),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(size.width * 0.05,
                                  size.height * 0.02, size.width * 0.05, 0),
                              child: FutureWeatherTile(data: data, index: 1),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.05,
                                  size.height * 0.02,
                                  size.width * 0.05,
                                  size.height * 0.02),
                              child: FutureWeatherTile(data: data, index: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                },
                error: (error, trace) {
                  return Center(
                      child: ErrorMessage(
                    errorString: error.toString(),
                    callback: () => ref.invalidate(weatherProvider),
                  ));
                },
                loading: () => const Center(
                  child: Loading(),
                ),
              )),
    );
  }
}
