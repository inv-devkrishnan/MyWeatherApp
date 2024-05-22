import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primaryTransColor,
      ),
      icon: const Icon(
        Icons.logout_rounded,
        color: Colors.white,
      ),
      onPressed: () async {
        await Authentication(FirebaseAuth.instance).logOut();
        context.mounted
            ? AutoRouter.of(context).replaceAll([const LoginRoute()])
            : debugPrint("context wasn't mounted");
      },
    );
  }
}
