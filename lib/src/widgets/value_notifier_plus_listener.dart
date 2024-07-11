import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';
import 'value_notifier_plus_callbacks.dart';

class ValueNotifierPlusListener<N extends ValueNotifierPlus<S>, S>
    extends StatefulWidget {
  const ValueNotifierPlusListener({
    Key? key,
    required this.listener,
    required this.child,
    required this.notifier,
  }) : super(key: key);
  final ValueNotifierPlusListenerCallback<S> listener;
  final Widget child;
  final N notifier;

  @override
  State<ValueNotifierPlusListener<N, S>> createState() =>
      _ValueNotifierPlusListenerState<N, S>();
}

class _ValueNotifierPlusListenerState<N extends ValueNotifierPlus<S>, S>
    extends State<ValueNotifierPlusListener<N, S>> {
  late S _state;

  @override
  void initState() {
    super.initState();
    _state = widget.notifier.state;
    widget.notifier.addListener(_listener);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (_state != widget.notifier.state) {
      setState(() {
        _state = widget.notifier.state;
      });
      widget.listener(context, _state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
