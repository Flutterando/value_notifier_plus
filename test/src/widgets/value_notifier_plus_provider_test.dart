import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import '../../conter_notifier.dart';

void main() {
  testWidgets('PlusProvider provides', (tester) async {
    final counterNotifier = CounterNotifier();

    await tester.pumpWidget(
      MaterialApp(
        home: PlusProvider<CounterNotifier>(
          provider: counterNotifier,
          child: Builder(
            builder: (context) {
              final counterProvider = PlusProvider.of<CounterNotifier>(context);
              final counterOf = context.of<CounterNotifier>();
              expect(counterProvider, counterNotifier);
              expect(counterOf, counterNotifier);
              return Text(counterOf.state.toString());
            },
          ),
        ),
      ),
    );
  });
  testWidgets('PlusProvider not provides throws FlutterError', (tester) async {
    final counterNotifier = CounterNotifier();

    await tester.pumpWidget(
      MaterialApp(
        home: PlusProvider<CounterNotifier>(
          provider: counterNotifier,
          child: Builder(
            builder: (context) {
              expect(() => context.of<int>(), throwsA(isA<FlutterError>()));
              return Text(counterNotifier.state.toString());
            },
          ),
        ),
      ),
    );
  });
  test('updateShouldNotify always returns false', () {
    // Cria um widget para ser usado como child
    final child = Container();

    // Cria duas instâncias de _PlusProviderInherited com provedores diferentes
    final inheritedWidget1 =
        PlusProviderInherited<int>(provider: 1, child: child);
    final inheritedWidget2 =
        PlusProviderInherited<int>(provider: 2, child: child);

    // Verifica se updateShouldNotify sempre retorna false
    expect(inheritedWidget1.updateShouldNotify(inheritedWidget2), isFalse);
  });

  test('updateShouldNotify always returns true', () {
    // Cria um widget para ser usado como child
    final container = Container();
    const sizedBox = SizedBox.shrink();

    // Cria duas instâncias de _PlusProviderInherited com provedores diferentes
    final inheritedWidget1 =
        PlusProviderInherited<int>(provider: 1, child: container);
    const inheritedWidget2 =
        PlusProviderInherited<int>(provider: 2, child: sizedBox);

    // Verifica se updateShouldNotify sempre retorna false
    expect(inheritedWidget1.updateShouldNotify(inheritedWidget2), isTrue);
  });
}
