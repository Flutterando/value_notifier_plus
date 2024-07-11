import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('PlusProvider provides notifier', (tester) async {
    final counterNotifier = CounterNotifier();

    await tester.pumpWidget(
      MaterialApp(
        home: PlusProvider<CounterNotifier>(
          provider: counterNotifier,
          child: Builder(
            builder: (context) {
              final counter = context.of<CounterNotifier>();
              return Text(counter.value.toString());
            },
          ),
        ),
      ),
    );
  });
}
