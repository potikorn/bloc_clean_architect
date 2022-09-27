import 'package:bloc_clean_architect/src/features/home/domain/use_cases/counter/restore.dart';
import 'package:bloc_clean_architect/src/features/home/domain/use_cases/counter/save_to_disk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(
    this._saveToDiskUseCase,
    this._restoreUseCase,
  ) : super(0) {
    _restoreFromDisk().then((value) => emit(value));
  }

  final SaveToDiskUseCase _saveToDiskUseCase;
  final RestoreUseCase _restoreUseCase;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  Future<void> saveToDisk() async => _saveToDiskUseCase.call(state);
  Future<int> _restoreFromDisk() async => _restoreUseCase.call();
}
