import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/weather_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  final String? loc;
  const HomePage({super.key, @PathParam('loc') this.loc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ResponsiveSafeArea(
          builder: (context, size) => Column(
                children: [
                  const Text("home page"),
                  FilledButton(
                    onPressed: () async {
                      await Authentication(FirebaseAuth.instance).logOut();
                      context.mounted
                          ? AutoRouter.of(context)
                              .replaceAll([const LoginRoute()])
                          : debugPrint("context wasn't mounted");
                    },
                    child: const Text("logout"),
                  ),
                  ref.watch(weatherProvider(loc)).when(
                        skipLoadingOnRefresh: false,
                        data: (data) {
                          return Text(data.toString());
                        },
                        error: (error, trace) {
                          return Text(error.toString());
                        },
                        loading: () => const CircularProgressIndicator(),
                      )
                ],
              )),
    );
  }
}
