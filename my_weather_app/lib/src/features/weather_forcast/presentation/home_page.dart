import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      child: const Text("logout"))
                ],
              )),
    );
  }
}
