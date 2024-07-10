import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('MultiValueNotifierPlusListener calls all listeners',
      (tester) async {
    final counterNotifier = CounterNotifier();
    int? listener1CalledWith;
    int? listener2CalledWith;

    await tester.pumpWidget(
      ValueNotifierPlusProvider<CounterNotifier>(
        notifier: counterNotifier,
        child: ValueNotifierPlusMultiListener(
          listeners: [
            ValueNotifierPlusListener<CounterNotifier, int>(
              listener: (context, state) {
                listener1CalledWith = state;
              },
              notifier: counterNotifier,
              child: Container(),
            ),
            ValueNotifierPlusListener<CounterNotifier, int>(
              notifier: counterNotifier,
              listener: (context, state) {
                listener2CalledWith = state;
              },
              child: Container(),
            ),
          ],
          child: Container(),
        ),
      ),
    );

    counterNotifier.increment();
    await tester.pump();
    expect(listener1CalledWith, 1);
    expect(listener2CalledWith, 1);
  });
}
