import 'package:bloc_clean_architect/src/features/counter/data/data_sources/local/counter_storage.dart';
import 'package:bloc_clean_architect/src/features/counter/domain/repository/counter_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ICounterRepository)
class CounterRepository extends ICounterRepository {
  final ICounterStorage _counterStorage;

  CounterRepository(this._counterStorage);

  @override
  int getCounterState() {
    return _counterStorage.readCounterState();
  }

  @override
  Future<bool> persistCounterState(int counter) {
    return _counterStorage.saveCounterState(counter);
  }
}
