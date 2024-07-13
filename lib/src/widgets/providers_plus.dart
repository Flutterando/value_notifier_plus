import 'package:flutter/widgets.dart';

import 'provider_plus.dart';

class ProvidersPlus extends StatelessWidget {
  final List<ProviderPlus> providers;
  final Widget child;

  const ProvidersPlus({
    Key? key,
    required this.providers,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget currentBuilder = child;

    for (final provider in providers.reversed) {
      currentBuilder = ProviderPlus(
        provider: provider.provider,
        child: provider.child,
      );
    }

    return currentBuilder;
  }
}
