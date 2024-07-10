import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/src/widgets/value_notifier_plus_multi_provider.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

class CounterNotifier1 extends CounterNotifier {}

class CounterNotifier2 extends CounterNotifier {}

void main() {
  testWidgets(
      'ValueNotifierPlusMultiProvider provides multiple notifiers using builders',
      (tester) async {
    final counterNotifier1 = CounterNotifier1();
    final counterNotifier2 = CounterNotifier2();

    await tester.pumpWidget(
      ValueNotifierPlusMultiProvider(
        providers: [
          ValueNotifierPlusProvider<CounterNotifier>(
            notifier: counterNotifier1,
            builder: (context) => Container(),
          ),
          ValueNotifierPlusProvider<CounterNotifier>(
            notifier: counterNotifier2,
            builder: (context) => Container(),
          ),
        ],
        builder: (context) {
          final notifier1 = context.of<CounterNotifier1>();
          final notifier2 = context.of<CounterNotifier2>();

          // Os notifiers fornecidos pelo contexto devem ser os mesmos que os inicializados
          expect(notifier1, counterNotifier1);
          expect(notifier2, counterNotifier2);
          return Container();
        },
      ),
    );
  });
}
