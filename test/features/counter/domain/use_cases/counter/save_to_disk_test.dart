import 'package:bloc_clean_architect/src/features/counter/data/repository/counter_repository.dart';
import 'package:bloc_clean_architect/src/features/counter/domain/use_cases/counter/save_to_disk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  group('saveToDiskUseCase', () {
    test('persist counter state to data source', () async {
      final counterRepository = MockCounterRepository();
      final SaveToDiskUseCase saveToDiskUseCase =
          SaveToDiskUseCase(counterRepository);
      const expectedCount = 5;

      when(() => counterRepository.persistCounterState(expectedCount))
          .thenAnswer(
        (_) async => true,
      );

      final actual = await saveToDiskUseCase.call(expectedCount);
      expect(actual, true);
      verify(() => counterRepository.persistCounterState(expectedCount))
          .called(1);
    });
  });
}
