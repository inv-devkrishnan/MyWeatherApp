import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/features/weather_forcast/presentation/providers/weather_provider.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  final String? loc;
  const HomePage({super.key, @PathParam('loc') this.loc});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

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
    ref.invalidate(weatherProvider(widget.loc));
  }

  @override
  Widget build(BuildContext context) {
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
                  ref.watch(weatherProvider(widget.loc)).when(
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
