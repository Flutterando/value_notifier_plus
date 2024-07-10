import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';
import 'value_notifier_plus_callbacks.dart';

class ValueNotifierPlusConsumer<N extends ValueNotifierPlus<S>, S>
    extends StatefulWidget {
  const ValueNotifierPlusConsumer({
    super.key,
    required this.builder,
    required this.listener,
    required this.notifier,
  });
  final ValueNotifierPlusWidgetBuilder<S> builder;
  final ValueNotifierPlusListenerCallback<S> listener;
  final N notifier;

  @override
  State<ValueNotifierPlusConsumer<N, S>> createState() =>
      _ValueNotifierPlusConsumerState<N, S>();
}

class _ValueNotifierPlusConsumerState<N extends ValueNotifierPlus<S>, S>
    extends State<ValueNotifierPlusConsumer<N, S>> {
  late N notifier;
  late S state;

  @override
  void initState() {
    super.initState();
    notifier = widget.notifier;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = notifier.state;
    notifier.addListener(_listener);
  }

  @override
  void dispose() {
    notifier.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {
      state = notifier.state;
    });
    widget.listener(context, state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
