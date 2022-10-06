// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_repository/authentication_repository.dart'
    as _i3;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;
import 'package:user_repository/user_repository.dart' as _i11;

import '../core/data/network/dio_client.dart' as _i5;
import '../features/counter/data/data_sources/local/counter_storage.dart'
    as _i13;
import '../features/counter/data/repository/counter_repository.dart' as _i15;
import '../features/counter/domain/repository/counter_repository.dart' as _i14;
import '../features/counter/domain/use_cases/counter/restore.dart' as _i16;
import '../features/counter/domain/use_cases/counter/save_to_disk.dart' as _i17;
import '../features/login/controllers/login_controller.dart' as _i9;
import '../features/post/data/data_sources/network/post_api.dart' as _i6;
import '../features/post/data/repository/post_repository.dart' as _i8;
import '../features/post/domain/repository/post_repository.dart' as _i7;
import '../features/post/domain/use_cases/get_posts.dart' as _i12;
import 'injector_module.dart' as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final authRepositoryModule = _$AuthRepositoryModule();
  final networkModule = _$NetworkModule();
  final appModule = _$AppModule();
  final userRepositoryModule = _$UserRepositoryModule();
  gh.singleton<_i3.AuthenticationRepository>(
      authRepositoryModule.authenticationRepository);
  gh.factory<_i4.Dio>(() => networkModule.dio);
  gh.singleton<_i5.DioClient>(_i5.DioClient(get<_i4.Dio>()));
  gh.factory<_i6.IPostApi>(() => _i6.PostApi(get<_i5.DioClient>()));
  gh.factory<_i7.IPostRepository>(
      () => _i8.PostRepository(get<_i6.IPostApi>()));
  gh.factory<_i9.LoginController>(() => _i9.LoginController(
      authenticationRepository: get<_i3.AuthenticationRepository>()));
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i11.UserRepository>(
      userRepositoryModule.authenticationRepository);
  gh.factory<_i12.GetPostsUseCase>(
      () => _i12.GetPostsUseCase(get<_i7.IPostRepository>()));
  gh.factory<_i13.ICounterStorage>(
      () => _i13.CounterStorage(get<_i10.SharedPreferences>()));
  gh.factory<_i14.ICounterRepository>(
      () => _i15.CounterRepository(get<_i13.ICounterStorage>()));
  gh.factory<_i16.RestoreUseCase>(
      () => _i16.RestoreUseCase(get<_i14.ICounterRepository>()));
  gh.factory<_i17.SaveToDiskUseCase>(
      () => _i17.SaveToDiskUseCase(get<_i14.ICounterRepository>()));
  return get;
}

class _$AuthRepositoryModule extends _i18.AuthRepositoryModule {}

class _$NetworkModule extends _i18.NetworkModule {}

class _$AppModule extends _i18.AppModule {}

class _$UserRepositoryModule extends _i18.UserRepositoryModule {}
