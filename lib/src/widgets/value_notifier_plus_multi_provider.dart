import 'package:flutter/widgets.dart';
import 'value_notifier_plus_provider.dart';

class ValueNotifierPlusMultiProvider extends StatelessWidget {
  final List<ValueNotifierPlusProvider> providers;
  final WidgetBuilder builder;

  const ValueNotifierPlusMultiProvider({
    super.key,
    required this.providers,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Widget currentBuilder = builder(context);

    for (final provider in providers.reversed) {
      currentBuilder = ValueNotifierPlusProvider(
        notifier: provider.notifier,
        builder: (context) => currentBuilder,
      );
    }

    return currentBuilder;
  }
}
