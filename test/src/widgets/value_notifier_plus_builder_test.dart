import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ValueNotifierPlusBuilder rebuilds when state changes',
      (tester) async {
    final counterNotifier = CounterNotifier();

    await tester.pumpWidget(
      ValueNotifierPlusBuilder<CounterNotifier, int>(
        notifier: counterNotifier,
        builder: (context, state) {
          return Text('$state', textDirection: TextDirection.ltr);
        },
      ),
    );

    expect(find.text('0'), findsOneWidget);
    counterNotifier.increment();
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
