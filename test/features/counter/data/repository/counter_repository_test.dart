import 'package:bloc_clean_architect/src/features/counter/data/data_sources/local/counter_storage.dart';
import 'package:bloc_clean_architect/src/features/counter/data/repository/counter_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterStorage extends Mock implements CounterStorage {}

void main() {
  group('counterRepository', () {
    late final CounterStorage counterStorage;
    late final CounterRepository counterRepository;

    setUpAll(() {
      counterStorage = MockCounterStorage();
      counterRepository = CounterRepository(counterStorage);
    });

    test('execute and return counter state from DB with corrected value', () {
      const expectedCount = 5;
      when(() => counterStorage.readCounterState()).thenReturn(expectedCount);

      final actual = counterRepository.getCounterState();
      expect(actual, expectedCount);
      verify(() => counterStorage.readCounterState()).called(1);
    });

    test('execute and save counter state to DB with corrected value', () async {
      const expectedCount = 5;
      when(() => counterStorage.saveCounterState(expectedCount)).thenAnswer(
        (_) async => true,
      );

      final actual = await counterRepository.persistCounterState(expectedCount);
      expect(actual, true);
      verify(() => counterStorage.saveCounterState(expectedCount)).called(1);
    });
  });
}
