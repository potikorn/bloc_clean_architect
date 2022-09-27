abstract class ICounterRepository {
  Future<bool> persistCounterState(int counter);
  int getCounterState();
}
