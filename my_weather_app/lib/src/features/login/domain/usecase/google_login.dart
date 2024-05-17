// ignore: implementation_imports

import 'package:my_weather_app/src/core/usecase/usecase.dart';
import 'package:my_weather_app/src/features/login/domain/repositories/login_repository.dart';

class GoogleLogin implements UseCase<void> {
  final LoginRespository loginRespository;
  GoogleLogin(this.loginRespository);
  @override
  Future<void> call() async {
    return await loginRespository.loginWithGoogle();
  }
}
