import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/location_change/presentation/widgets/fav_btn.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/location_provider.dart';

import '../../../weather_forcast/presentation/providers/location_list_provider.dart';
import '../../../weather_forcast/presentation/widgets/error.dart';

@RoutePage()
class SetLocationPage extends ConsumerStatefulWidget {
  const SetLocationPage({super.key});

  @override
  ConsumerState<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends ConsumerState<SetLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
      ),
      backgroundColor: AppColors.primaryColor,
      body: ResponsiveSafeArea(
          builder: (context, size) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.location_searching_outlined,
                      color: AppColors.primaryTextColor,
                    ),
                    title: const Text("Current Location",
                        style: TextStyle(color: AppColors.primaryTextColor)),
                    onTap: () {
                      ref.read(placeProvider.notifier).state = ":loc";
                      AutoRouter.of(context).maybePop();
                    },
                  ),
                  ref.watch(locationListProvider).when(
                        data: (data) => SizedBox(
                          height: size.height * 0.9,
                          child: ListView.builder(
                              itemCount: data.places.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  title: Text(
                                    data.places[index],
                                    style: const TextStyle(
                                        color: AppColors.primaryTextColor),
                                  ),
                                  trailing: FavBtn(data.places[index]),
                                  onTap: () {
                                    ref.read(placeProvider.notifier).state =
                                        data.places[index];

                                    AutoRouter.of(context).maybePop();
                                  },
                                );
                              }),
                        ),
                        error: (error, stack) => ErrorMessage(
                            errorString: error.toString(),
                            callback: () {
                              ref.invalidate(locationListProvider);
                            }),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                      )
                ],
              )),
    );
  }
}
