import 'package:flutter_test/flutter_test.dart';

import '../conter_notifier.dart';

void main() {
  group('CounterNotifier', () {
    test('initial state is 0', () {
      final notifier = CounterNotifier();
      expect(notifier.state, 0);
    });
    test('dispose listener', () {
      final notifier = CounterNotifier();
      notifier.addListener(() {});
      notifier.close();
      // ignore: invalid_use_of_protected_member
      expect(notifier.hasListeners, false);
    });

    test('increment updates state to 1', () {
      final notifier = CounterNotifier();
      notifier.increment();
      expect(notifier.state, 1);
    });

    test('decrement updates state to -1', () {
      final notifier = CounterNotifier();
      notifier.decrement();
      expect(notifier.state, -1);
    });
  });
}
