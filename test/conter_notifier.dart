import 'package:value_notifier_plus/value_notifier_plus.dart';

class CounterNotifier extends ValueNotifierPlus<int> {
  CounterNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
