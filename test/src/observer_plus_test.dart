import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../conter_notifier.dart';

void main() {
  group('ObserverPlus', () {
    test('observer is notified on state change', () {
      final observer = TestObserver();
      ValueNotifierPlus.observer = observer;
      final notifier = CounterNotifier();

      notifier.increment();
      expect(observer.states, [1]);

      notifier.increment();
      expect(observer.states, [1, 2]);

      notifier.decrement();
      expect(observer.states, [1, 2, 1]);

      ValueNotifierPlus.observer = null; // Reset observer
    });

    test('observer is not notified if the state does not change', () {
      final observer = TestObserver();
      ValueNotifierPlus.observer = observer;
      final notifier = CounterNotifier();

      notifier.emit(0); // Emit the same state
      expect(observer.states, isEmpty);

      ValueNotifierPlus.observer = null; // Reset observer
    });
  });
}

class TestObserver extends ObserverPlus {
  final List<Object?> states = [];

  @override
  void onChange<ValueNotifierPlusType extends ValueNotifierPlus>(
    ValueNotifierPlusType notifier,
    Object? state,
  ) {
    states.add(state);
  }
}
