import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/globals/global_keys.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';
import 'package:my_weather_app/src/features/login/presentation/provider/login_repository_provider.dart';

final loginControllerProvider = StateNotifierProvider.autoDispose<
    LoginController, AsyncValue<UserCredential?>>((ref) {
  return LoginController(ref);
});

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<UserCredential?>>(
      loginControllerProvider,
      (_, state) {
        if (state.hasError) {
          scaffoldkey.currentState!.showSnackBar(
            const SnackBar(
              content: Text("Unexpected error occured ,Try again"),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
      },
    );
    final state =
        ref.watch<AsyncValue<UserCredential?>>(loginControllerProvider);

    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: Colors.white),
      onPressed: state.isLoading
          ? null
          : () async {
              ref
                  .read(loginControllerProvider.notifier)
                  .signInWithGoogle(context);
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Builder(builder: (context) {
          if (state.isLoading) {
            return const SizedBox(
              height: 32,
              width: 32,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return Row(mainAxisSize: MainAxisSize.min, children: [
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
            ]);
          }
        }),
      ),
    );
  }
}
