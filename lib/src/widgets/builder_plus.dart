import 'package:flutter/widgets.dart';

import '../../value_notifier_plus.dart';
import 'callbacks_plus.dart';

typedef BuilderPlusWhen<T> = bool Function(T previous, T current);

class BuilderPlus<N extends ValueNotifierPlus<S>, S> extends StatefulWidget {
  const BuilderPlus({
    Key? key,
    required this.builder,
    required this.notifier,
    this.buildWhen,
  }) : super(key: key);
  final WidgetBuilderPlus<S> builder;
  final N notifier;
  final BuilderPlusWhen? buildWhen;

  @override
  State<BuilderPlus<N, S>> createState() => _BuilderPlusState<N, S>();
}

class _BuilderPlusState<N extends ValueNotifierPlus<S>, S>
    extends State<BuilderPlus<N, S>> {
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
    final buildWhen = widget.buildWhen;
    if (buildWhen == null || buildWhen(state, notifier.state)) {
      setState(() {
        state = notifier.state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
