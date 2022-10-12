import 'package:bloc_clean_architect/src/features/counter/domain/repository/counter_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RestoreUseCase {
  final ICounterRepository _counterRepository;

  RestoreUseCase(this._counterRepository);

  int call() {
    return _counterRepository.getCounterState();
  }
}
