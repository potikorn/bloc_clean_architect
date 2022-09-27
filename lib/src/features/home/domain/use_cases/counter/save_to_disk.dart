import 'package:bloc_clean_architect/src/features/home/domain/repository/counter_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveToDiskUseCase {
  final ICounterRepository _counterRepository;

  SaveToDiskUseCase(this._counterRepository);

  Future<bool> call(int count) {
    return _counterRepository.persistCounterState(count);
  }
}
