import 'package:flutter/widgets.dart';

import 'value_notifier_plus_provider.dart';

class ValueNotifierPlusProviders extends StatelessWidget {
  final List<PlusProvider> providers;
  final Widget child;

  const ValueNotifierPlusProviders({
    Key? key,
    required this.providers,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget currentBuilder = child;

    for (final provider in providers.reversed) {
      currentBuilder = PlusProvider(
        provider: provider.provider,
        child: provider.child,
      );
    }

    return currentBuilder;
  }
}
