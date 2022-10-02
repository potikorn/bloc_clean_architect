import 'package:bloc_clean_architect/src/features/counter/data/repository/counter_repository.dart';
import 'package:bloc_clean_architect/src/features/counter/domain/use_cases/counter/restore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  group('restoreUseCase', () {
    test('fetch counter state from data source', () {
      final counterRepository = MockCounterRepository();
      final RestoreUseCase restoreUseCase = RestoreUseCase(counterRepository);
      const expectedCount = 5;

      when(() => counterRepository.getCounterState()).thenReturn(expectedCount);

      final actual = restoreUseCase.call();
      expect(actual, expectedCount);
      verify(() => counterRepository.getCounterState()).called(1);
    });
  });
}
