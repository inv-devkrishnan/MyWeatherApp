// ignore_for_file: unnecessary_const

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather_app/src/core/responsive/safe_area.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/login/presentation/widgets/google_sign_in_button.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "MyWeatherApp",
                            minFontSize: 32,
                            maxLines: 1,
                            style: TextStyle(fontSize: 46, color: Colors.white),
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
