import 'package:flutter/widgets.dart';

import 'listener_plus.dart';

class ListenersPlus extends StatelessWidget {
  const ListenersPlus({
    Key? key,
    required this.listeners,
    required this.child,
  }) : super(key: key);
  final List<ListenerPlus> listeners;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var current = child;
    for (final listener in listeners.reversed) {
      current = ListenerPlus(
        notifier: listener.notifier,
        key: listener.key,
        listener: listener.listener,
        child: current,
      );
    }
    return current;
  }
}
