import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/features/login/data/datasource/login_remote_data_source.dart';
import 'package:my_weather_app/src/features/login/data/repositories/login_repository_impl.dart';
import 'package:my_weather_app/src/features/login/domain/repositories/login_repository.dart';

final loginRepositoryProvider = Provider<LoginRespository>((ref) {
  return LoginRespositoryImpl(LoginRemoteDateSourceImpl());
});

class LoginController extends StateNotifier<AsyncValue<UserCredential?>> {
  LoginController(this.ref)
      // set the initial state
      : super(const AsyncData(null));
  final Ref ref;

  Future<void> signInWithGoogle(BuildContext context) async {
    // read the repository using ref
    final authRepository = ref.read(loginRepositoryProvider);
    // set the loading state
    state = const AsyncLoading();
    // sign in and update the state (data or error)
    state = await AsyncValue.guard(authRepository.loginWithGoogle);
    if (context.mounted && !state.hasError) {
      AutoRouter.of(context).replace(const HomeRoute());
    }
  }
}
