import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ValueNotifierPlusProvider provides notifier', (tester) async {
    final counterNotifier = CounterNotifier();

    await tester.pumpWidget(
      PlusProvider<CounterNotifier>(
        provider: counterNotifier,
        builder: (context) {
          final notifier = context.of<CounterNotifier>();

          expect(notifier, counterNotifier);
          return Container();
        },
      ),
    );
  });
}
