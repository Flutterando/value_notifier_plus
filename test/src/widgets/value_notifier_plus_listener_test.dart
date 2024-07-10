import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ValueNotifierPlusListener calls listener on state change',
      (tester) async {
    final counterNotifier = CounterNotifier();
    int? listenerCalledWith;

    await tester.pumpWidget(
      ValueNotifierPlusListener<CounterNotifier, int>(
        listener: (context, state) {
          listenerCalledWith = state;
        },
        notifier: counterNotifier,
        child: Container(),
      ),
    );

    counterNotifier.increment();
    await tester.pump();
    expect(listenerCalledWith, 1);
  });
}
