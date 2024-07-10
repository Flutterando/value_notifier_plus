import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/src/widgets/value_notifier_plus_multi_provider.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('ValueNotifierPlusMultiProvider provides multiple notifiers',
      (tester) async {
    final counterNotifier1 = CounterNotifier();
    final counterNotifier2 = CounterNotifier();

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
        builder: (context) => Builder(
          builder: (context) {
            final notifier1 =
                ValueNotifierPlusProvider.of<CounterNotifier>(context);
            final notifier2 =
                ValueNotifierPlusProvider.of<CounterNotifier>(context);

            expect(notifier1, counterNotifier1);
            expect(notifier2, counterNotifier2);
            return Container();
          },
        ),
      ),
    );
  });
}
