import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

class CounterNotifier1 extends CounterNotifier {}

class CounterNotifier2 extends CounterNotifier {}

void main() {
  testWidgets('ProvidersPlus provides multiple notifiers using builders',
      (tester) async {
    final counterNotifier1 = CounterNotifier1();
    final counterNotifier2 = CounterNotifier2();

    await tester.pumpWidget(
      ProvidersPlus(
        providers: [
          ProviderPlus<CounterNotifier1>(
            provider: counterNotifier1,
            child: Container(),
          ),
          ProviderPlus<CounterNotifier2>(
            provider: counterNotifier2,
            child: Container(),
          ),
        ],
        child: Builder(builder: (context) {
          final notifier1 = context.of<CounterNotifier1>();
          final notifier2 = context.of<CounterNotifier2>();

          // Os notifiers fornecidos pelo contexto devem ser os mesmos que os inicializados
          expect(notifier1, counterNotifier1);
          expect(notifier2, counterNotifier2);
          return Container();
        }),
      ),
    );
  });
}
