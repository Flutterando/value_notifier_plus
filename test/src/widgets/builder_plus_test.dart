import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  group('BuilderPlus', () {
    testWidgets('rebuilds when state changes', (tester) async {
      final counterNotifier = CounterNotifier();

      await tester.pumpWidget(
        BuilderPlus<CounterNotifier, int>(
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

    testWidgets('do NOT rebuilds when "buildWhen" is not true', (tester) async {
      final counterNotifier = CounterNotifier();

      await tester.pumpWidget(
        BuilderPlus<CounterNotifier, int>(
          notifier: counterNotifier,
          buildWhen: (previous, current) => current > previous + 2,
          builder: (context, state) {
            return Text('$state', textDirection: TextDirection.ltr);
          },
        ),
      );

      expect(find.text('0'), findsOneWidget);
      counterNotifier.increment();
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('rebuilds when "buildWhen" is true', (tester) async {
      final counterNotifier = CounterNotifier();

      await tester.pumpWidget(
        BuilderPlus<CounterNotifier, int>(
          notifier: counterNotifier,
          builder: (context, state) {
            return Text('$state', textDirection: TextDirection.ltr);
          },
        ),
      );

      expect(find.text('0'), findsOneWidget);
      counterNotifier.increment();
      counterNotifier.increment();
      counterNotifier.increment();
      await tester.pump();
      expect(find.text('3'), findsOneWidget);
    });
  });
}
