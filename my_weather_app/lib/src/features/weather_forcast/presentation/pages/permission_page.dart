import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';

@RoutePage()
class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveSafeArea(
          builder: (context, size) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1, vertical: size.height * 0.05),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Lottie.asset("assets/animation/location_anim.json"),
                      const AutoSizeText(
                        "Location Access",
                        maxLines: 1,
                        maxFontSize: 48,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: const AutoSizeText(
                            "MyWeatherApp needs access to your real-time location to provide you with the latest weather updates for your area. Please grant MyWeatherApp the necessary location permissions.",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: FilledButton.icon(
                            icon: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            label: const Text("Allow Location")),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Exit Application",
                                style: TextStyle(),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
