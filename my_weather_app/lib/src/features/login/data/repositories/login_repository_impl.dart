// ignore: implementation_imports

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_weather_app/src/features/login/data/datasource/login_remote_data_source.dart';
import 'package:my_weather_app/src/features/login/domain/repositories/login_repository.dart';

class LoginRespositoryImpl implements LoginRespository {
  final LoginRemoteDataSource loginRemoteDataSource;

  const LoginRespositoryImpl(this.loginRemoteDataSource);

  @override
  Future<UserCredential> loginWithGoogle() async {
    return await loginRemoteDataSource.loginWithGoogle();
  }
}
