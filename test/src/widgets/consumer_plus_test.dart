import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ConsumerPlus rebuilds and calls listener', (tester) async {
    final counterNotifier = CounterNotifier();
    int? listenerCalledWith;

    await tester.pumpWidget(
      ConsumerPlus<CounterNotifier, int>(
        listener: (context, state) {
          listenerCalledWith = state;
        },
        builder: (context, state) {
          return Text('$state', textDirection: TextDirection.ltr);
        },
        notifier: counterNotifier,
      ),
    );

    expect(find.text('0'), findsOneWidget);
    counterNotifier.increment();
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(listenerCalledWith, 1);
  });
}
