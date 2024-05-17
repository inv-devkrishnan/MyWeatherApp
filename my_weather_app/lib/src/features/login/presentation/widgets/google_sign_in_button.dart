import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_weather_app/src/features/login/data/datasource/login_remote_data_source.dart';
import 'package:my_weather_app/src/features/login/data/repositories/login_repository_impl.dart';
import 'package:my_weather_app/src/features/login/domain/usecase/google_login.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () async {
        await GoogleLogin(LoginRespositoryImpl(LoginRemoteDateSourceImpl()))
            .call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                "assets/images/google_icon.svg",
                height: 24,
                width: 24,
              ),
            ),
            const Text(
              "Sign in with Google",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
