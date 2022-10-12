import 'package:bloc_clean_architect/src/features/counter/data/data_sources/local/counter_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterStorage extends Mock implements CounterStorage {}

class MockSharedPref extends Mock implements SharedPreferences {}

void main() {
  group('counterStorage', () {
    group('readCounterState', () {
      test('return 0 if no value store in shared preferences', () async {
        SharedPreferences.setMockInitialValues({
          CounterStorage.countKey: 0,
        });

        final sharedPreferences = await SharedPreferences.getInstance();
        final counterStorage = CounterStorage(sharedPreferences);

        const expectedCount = 0;
        final actualCount = counterStorage.readCounterState();

        expect(actualCount, expectedCount);
      });

      test('return the correct value stored in shared preferences', () async {
        const counterValue = 42;
        SharedPreferences.setMockInitialValues({
          CounterStorage.countKey: counterValue,
        });

        final sharedPreferences = await SharedPreferences.getInstance();
        final counterStorage = CounterStorage(sharedPreferences);

        const expectedCount = counterValue;
        final actualCount = counterStorage.readCounterState();

        expect(actualCount, expectedCount);
      });
    });

    group('saveCounterState', () {
      test('stores the correct count value in shared preferences', () async {
        const counterValue = 42;
        SharedPreferences.setMockInitialValues({});
        final sharedPreferences = await SharedPreferences.getInstance();
        final counterStorage = CounterStorage(sharedPreferences);

        counterStorage.saveCounterState(counterValue);
        const expectedCount = counterValue;
        final actualCount = sharedPreferences.getInt(CounterStorage.countKey);

        expect(actualCount, expectedCount);
      });
    });
  });
}
