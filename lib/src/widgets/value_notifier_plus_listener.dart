import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';
import 'value_notifier_plus_callbacks.dart';
import 'value_notifier_plus_provider.dart';

class ValueNotifierPlusListener<N extends ValueNotifierPlus<S>, S>
    extends StatefulWidget {
  const ValueNotifierPlusListener({
    required this.listener,
    required this.child,
    super.key,
  });
  final ValueNotifierPlusListenerCallback<S> listener;
  final Widget child;

  @override
  State<ValueNotifierPlusListener<N, S>> createState() =>
      _ValueNotifierPlusListenerState<N, S>();
}

class _ValueNotifierPlusListenerState<N extends ValueNotifierPlus<S>, S>
    extends State<ValueNotifierPlusListener<N, S>> {
  late N notifier;
  late S state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifier = ValueNotifierPlusProvider.of<N>(context);
    state = notifier.state;
    notifier.addListener(_listener);
  }

  @override
  void dispose() {
    notifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    widget.listener(context, notifier.state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
