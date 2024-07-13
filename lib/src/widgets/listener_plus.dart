import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';
import 'callbacks_plus.dart';

class ListenerPlus<N extends ValueNotifierPlus<S>, S> extends StatefulWidget {
  const ListenerPlus({
    Key? key,
    required this.listener,
    required this.child,
    required this.notifier,
  }) : super(key: key);
  final ListenerCallbackPlus<S> listener;
  final Widget child;
  final N notifier;

  @override
  State<ListenerPlus<N, S>> createState() => _ListenerPlusState<N, S>();
}

class _ListenerPlusState<N extends ValueNotifierPlus<S>, S>
    extends State<ListenerPlus<N, S>> {
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
