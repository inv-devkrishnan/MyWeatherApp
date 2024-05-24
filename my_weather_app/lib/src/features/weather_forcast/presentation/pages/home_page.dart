import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/weather_provider.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/service/weather_image.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/background_image.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/change_location_btn.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/current_weather.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/error.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/future_weather_tile.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/loading.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/logout_btn.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/sub_heading.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/widgets/weather_info_blocks.dart';

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
  String? loadLocation;
  @override
  void initState() {
    super.initState();
    loadLocation = widget.loc;
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onResumed();
    }
  }

  void _onResumed() {
    debugPrint("App resumed");
    ref.invalidate(weatherProvider);
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
                    SingleChildScrollView(
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
                                size: size, heading: "Current Forecast"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: SizedBox(
                              width: size.width,
                              height: 150,
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
                                        imagePath: "assets/images/uv_index.svg",
                                        heading: "UV Index",
                                        body: "${data.current.uv}"),
                                    WeatherInfoBlocks(
                                        size: size,
                                        imagePath: "assets/images/rain.svg",
                                        heading: "Chance of rain",
                                        body:
                                            "${data.forecast.forecastday[0].day.chanceOfRain} %"),
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
                            padding: EdgeInsets.fromLTRB(size.width * 0.05,
                                size.height * 0.02, size.width * 0.05, 0),
                            child: FutureWeatherTile(data: data, index: 2),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.05,
                                size.height * 0.02,
                                size.width * 0.05,
                                size.height * 0.02),
                            child: FutureWeatherTile(data: data, index: 3),
                          ),
                        ],
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
