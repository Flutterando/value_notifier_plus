import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ListenersPlus calls listeners', (WidgetTester tester) async {
    final counterNotifier1 = CounterNotifier();
    final counterNotifier2 = CounterNotifier();

    var listener1Called = false;
    var listener2Called = false;

    await tester.pumpWidget(
      ListenersPlus(
        listeners: [
          ListenerPlus<CounterNotifier, dynamic>(
            notifier: counterNotifier1,
            listener: (context, state) {
              listener1Called = true;
            },
            child: Container(),
          ),
          ListenerPlus<CounterNotifier, dynamic>(
            notifier: counterNotifier2,
            listener: (context, state) {
              listener2Called = true;
            },
            child: Container(),
          ),
        ],
        child: Container(),
      ),
    );

    await tester.pump();

    counterNotifier1.increment();
    counterNotifier2.increment();

    await tester.pump();

    expect(listener1Called, isTrue);
    expect(listener2Called, isTrue);
  });
}
