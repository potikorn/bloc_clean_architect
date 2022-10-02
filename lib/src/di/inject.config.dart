// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../core/data/network/dio_client.dart' as _i4;
import '../features/counter/data/data_sources/local/counter_storage.dart'
    as _i10;
import '../features/counter/data/repository/counter_repository.dart' as _i12;
import '../features/counter/domain/repository/counter_repository.dart' as _i11;
import '../features/counter/domain/use_cases/counter/restore.dart' as _i13;
import '../features/counter/domain/use_cases/counter/save_to_disk.dart' as _i14;
import '../features/post/data/data_sources/network/post_api.dart' as _i5;
import '../features/post/data/repository/post_repository.dart' as _i7;
import '../features/post/domain/repository/post_repository.dart' as _i6;
import '../features/post/domain/use_cases/get_posts.dart' as _i9;
import 'injector_module.dart' as _i15; // ignore_for_file: unnecessary_lambdas

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
  final networkModule = _$NetworkModule();
  final appModule = _$AppModule();
  gh.factory<_i3.Dio>(() => networkModule.dio);
  gh.singleton<_i4.DioClient>(_i4.DioClient(get<_i3.Dio>()));
  gh.factory<_i5.IPostApi>(() => _i5.PostApi(get<_i4.DioClient>()));
  gh.factory<_i6.IPostRepository>(
      () => _i7.PostRepository(get<_i5.IPostApi>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.factory<_i9.GetPostsUseCase>(
      () => _i9.GetPostsUseCase(get<_i6.IPostRepository>()));
  gh.factory<_i10.ICounterStorage>(
      () => _i10.CounterStorage(get<_i8.SharedPreferences>()));
  gh.factory<_i11.ICounterRepository>(
      () => _i12.CounterRepository(get<_i10.ICounterStorage>()));
  gh.factory<_i13.RestoreUseCase>(
      () => _i13.RestoreUseCase(get<_i11.ICounterRepository>()));
  gh.factory<_i14.SaveToDiskUseCase>(
      () => _i14.SaveToDiskUseCase(get<_i11.ICounterRepository>()));
  return get;
}

class _$NetworkModule extends _i15.NetworkModule {}

class _$AppModule extends _i15.AppModule {}
