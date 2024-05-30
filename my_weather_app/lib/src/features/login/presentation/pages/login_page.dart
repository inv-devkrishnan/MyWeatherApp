// ignore_for_file: unnecessary_const

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/login/presentation/widgets/google_sign_in_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ResponsiveSafeArea(
          builder: (context, size) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: size.height,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.7,
                          width: size.width,
                          child: Column(
                            children: [
                              Lottie.asset(
                                "assets/animation/sun_cloud_anim.json",
                                height: size.height * 0.5,
                                width: size.height * 0.5,
                              ),
                              SizedBox(
                                height: size.height * 0.1,
                                width: size.width,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    "MyWeatherApp",
                                    maxFontSize: 48,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 42,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.1,
                                child: const AutoSizeText(
                                  maxLines: 1,
                                  "Sign in to continue",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.2,
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.05),
                            child: const Align(
                              alignment: Alignment.bottomCenter,
                              child: GoogleSignInButton(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
