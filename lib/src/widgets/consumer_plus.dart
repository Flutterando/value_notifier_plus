import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';
import 'callbacks_plus.dart';

class ConsumerPlus<N extends ValueNotifierPlus<S>, S> extends StatefulWidget {
  const ConsumerPlus({
    Key? key,
    required this.builder,
    required this.listener,
    required this.notifier,
  }) : super(key: key);
  final WidgetBuilderPlus<S> builder;
  final ListenerCallbackPlus<S> listener;
  final N notifier;

  @override
  State<ConsumerPlus<N, S>> createState() => _ConsumerPlusState<N, S>();
}

class _ConsumerPlusState<N extends ValueNotifierPlus<S>, S>
    extends State<ConsumerPlus<N, S>> {
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
