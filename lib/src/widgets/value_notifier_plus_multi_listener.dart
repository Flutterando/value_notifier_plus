import 'package:flutter/widgets.dart';

import 'value_notifier_plus_listener.dart';

class ValueNotifierPlusMultiListener extends StatelessWidget {
  const ValueNotifierPlusMultiListener({
    required this.listeners,
    required this.child,
    super.key,
  });
  final List<ValueNotifierPlusListener> listeners;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var current = child;
    for (final listener in listeners.reversed) {
      current = ValueNotifierPlusListener(
        key: listener.key,
        listener: listener.listener,
        child: current,
      );
    }
    return current;
  }
}
