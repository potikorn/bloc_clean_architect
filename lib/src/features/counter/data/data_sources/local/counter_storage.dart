import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICounterStorage {
  Future<bool> saveCounterState(int counter);
  int readCounterState();
}

@Injectable(as: ICounterStorage)
class CounterStorage extends ICounterStorage {
  CounterStorage(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @visibleForTesting
  static const String countKey = 'counter';

  @override
  int readCounterState() {
    return _sharedPreferences.getInt(countKey) ?? 0;
  }

  @override
  Future<bool> saveCounterState(int counter) async {
    return _sharedPreferences.setInt(countKey, counter);
  }
}
