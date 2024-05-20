// ignore: implementation_imports

import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/features/login/data/datasource/login_remote_data_source.dart';
import 'package:my_weather_app/src/features/login/domain/repositories/login_repository.dart';

class LoginRespositoryImpl implements LoginRespository {
  final LoginRemoteDataSource loginRemoteDataSource;

  const LoginRespositoryImpl(this.loginRemoteDataSource);

  @override
  Future<void> loginWithGoogle() async {
    try {
      await loginRemoteDataSource.loginWithGoogle();
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
