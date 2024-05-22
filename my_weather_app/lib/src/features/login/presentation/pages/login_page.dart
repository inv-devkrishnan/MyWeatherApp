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
                child: Stack(
                  children: [
                    Lottie.asset(
                      "assets/animation/sun_cloud_anim.json",
                    ),
                    const Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
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
                          const Text(
                            "Sign in to continue",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * 0.05),
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: GoogleSignInButton(),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
