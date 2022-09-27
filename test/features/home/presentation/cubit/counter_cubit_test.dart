import 'package:bloc_clean_architect/src/features/home/domain/use_cases/counter/restore.dart';
import 'package:bloc_clean_architect/src/features/home/domain/use_cases/counter/save_to_disk.dart';
import 'package:bloc_clean_architect/src/features/home/presentation/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveToDiskUseCase extends Mock implements SaveToDiskUseCase {}

class MockRestoreUseCase extends Mock implements RestoreUseCase {}

void main() {
  group('CounterCubit', () {
    late SaveToDiskUseCase saveToDiskUseCase;
    late RestoreUseCase restoreUseCase;
    late CounterCubit counterCubit;

    setUp(() {
      saveToDiskUseCase = MockSaveToDiskUseCase();
      restoreUseCase = MockRestoreUseCase();
      when(() => restoreUseCase.call()).thenReturn(0);
      counterCubit = CounterCubit(saveToDiskUseCase, restoreUseCase);
    });

    blocTest<CounterCubit, int>(
      'emits initial state with read count state '
      'from DB CounterCubit is created.',
      build: () => counterCubit,
      expect: () => const <int>[],
      verify: (_) async {
        verify(() => restoreUseCase.call()).called(1);
      },
    );

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => const <int>[1],
    );

    blocTest<CounterCubit, int>(
      'emits [1] when decrement is called',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => const <int>[-1],
    );

    blocTest<CounterCubit, int>(
      'emits save count state to DB CounterCubit is created.',
      setUp: () {
        when(() => saveToDiskUseCase.call(0)).thenAnswer(
          (_) async => true,
        );
      },
      build: () => counterCubit,
      act: (cubit) => cubit.saveToDisk(),
      verify: (_) async {
        verify(() => saveToDiskUseCase.call(0)).called(1);
      },
    );
  });
}
