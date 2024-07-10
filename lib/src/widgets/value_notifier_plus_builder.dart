import 'package:flutter/widgets.dart';
import 'package:value_notifier_plus/value_notifier_plus.dart';

import 'value_notifier_plus_callbacks.dart';

class ValueNotifierPlusBuilder<N extends ValueNotifierPlus<S>, S>
    extends StatefulWidget {
  const ValueNotifierPlusBuilder({
    required this.builder,
    super.key,
  });
  final ValueNotifierPlusWidgetBuilder<S> builder;

  @override
  State<ValueNotifierPlusBuilder<N, S>> createState() =>
      _ValueNotifierPlusBuilderState<N, S>();
}

class _ValueNotifierPlusBuilderState<N extends ValueNotifierPlus<S>, S>
    extends State<ValueNotifierPlusBuilder<N, S>> {
  late N notifier;
  late S state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newNotifier = ValueNotifierPlusProvider.of<N>(context);
    if (notifier != newNotifier) {
      notifier = newNotifier;
      state = notifier.state;
      notifier.addListener(_listener);
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
