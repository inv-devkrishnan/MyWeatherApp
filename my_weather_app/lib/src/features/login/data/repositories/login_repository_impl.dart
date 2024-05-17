// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:my_weather_app/src/core/Error/failure.dart';
import 'package:my_weather_app/src/core/error/exception.dart';
import 'package:my_weather_app/src/features/login/data/datasource/login_remote_data_source.dart';
import 'package:my_weather_app/src/features/login/domain/repositories/login_repository.dart';

class LoginRespositoryImpl implements LoginRespository {
  final LoginRemoteDataSource loginRemoteDataSource;

  const LoginRespositoryImpl(this.loginRemoteDataSource);

  @override
  Future<Either<Failure, void>> loginWithGoogle() async {
    try {
      await loginRemoteDataSource.loginWithGoogle();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
