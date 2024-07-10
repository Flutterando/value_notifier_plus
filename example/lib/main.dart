import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

class CounterNotifier extends ValueNotifierPlus<int> {
  CounterNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class MyObserver extends ValueNotifierPlusObserver {
  @override
  void onChange<ValueNotifierPlusType extends ValueNotifierPlus>(
    ValueNotifierPlusType notifier,
    Object? state,
  ) {
    log('Notifier: $notifier, State: $state');
  }
}

void main() {
  ValueNotifierPlus.observer = MyObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueNotifierPlusProvider(
      notifier: CounterNotifier(),
      child: const MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = ValueNotifierPlusProvider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Notifier'),
      ),
      body: Center(
        child: ValueNotifierPlusConsumer<CounterNotifier, int>(
          notifier: counter,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('State changed to $state')),
            );
          },
          builder: (context, count) {
            return Text(
              '$count',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              counter.increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              counter.decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
