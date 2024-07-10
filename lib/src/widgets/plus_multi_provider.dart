import 'package:flutter/widgets.dart';
import 'plus_provider.dart';

class PlusMultiProvider extends StatelessWidget {
  final List<PlusProvider> providers;
  final WidgetBuilder builder;

  const PlusMultiProvider({
    super.key,
    required this.providers,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Widget currentBuilder = builder(context);

    for (final provider in providers.reversed) {
      currentBuilder = PlusProvider(
        provider: provider.provider,
        builder: provider.builder,
      );
    }

    return currentBuilder;
  }
}
