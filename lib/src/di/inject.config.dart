// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../features/home/data/data_sources/local/counter_storage.dart' as _i4;
import '../features/home/data/repository/counter_repository.dart' as _i6;
import '../features/home/domain/repository/counter_repository.dart' as _i5;
import '../features/home/domain/use_cases/counter/restore.dart' as _i7;
import '../features/home/domain/use_cases/counter/save_to_disk.dart' as _i8;
import 'injector_module.dart' as _i9; // ignore_for_file: unnecessary_lambdas

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
  final appModule = _$AppModule();
  await gh.factoryAsync<_i3.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.factory<_i4.ICounterStorage>(
      () => _i4.CounterStorage(get<_i3.SharedPreferences>()));
  gh.factory<_i5.ICounterRepository>(
      () => _i6.CounterRepository(get<_i4.ICounterStorage>()));
  gh.factory<_i7.RestoreUseCase>(
      () => _i7.RestoreUseCase(get<_i5.ICounterRepository>()));
  gh.factory<_i8.SaveToDiskUseCase>(
      () => _i8.SaveToDiskUseCase(get<_i5.ICounterRepository>()));
  return get;
}

class _$AppModule extends _i9.AppModule {}
