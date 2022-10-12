import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class NetworkModule {
  Dio get dio => Dio();
}

@module
abstract class AuthRepositoryModule {
  @singleton
  AuthenticationRepository get authenticationRepository =>
      AuthenticationRepository();
}

@module
abstract class UserRepositoryModule {
  @singleton
  UserRepository get authenticationRepository => UserRepository();
}
