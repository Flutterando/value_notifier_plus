import 'package:flutter/widgets.dart';

class ProviderPlus<T> extends StatefulWidget {
  const ProviderPlus({
    Key? key,
    required this.provider,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T provider;

  @override
  State<ProviderPlus<T>> createState() => _ProviderPlusState<T>();

  static T of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PlusProviderInherited<T>>();
    return provider!.provider;
  }
}

class _ProviderPlusState<T> extends State<ProviderPlus<T>> {
  @override
  Widget build(BuildContext context) {
    return PlusProviderInherited<T>(
      provider: widget.provider,
      child: widget.child,
    );
  }
}

class PlusProviderInherited<T> extends InheritedWidget {
  final T provider;

  const PlusProviderInherited(
      {Key? key, required Widget child, required this.provider})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}

extension PlusProviderExtension on BuildContext {
  T of<T>() {
    final provider =
        dependOnInheritedWidgetOfExactType<PlusProviderInherited<T>>();
    if (provider == null) {
      throw FlutterError('No PlusProvider<$T> found in context');
    }
    return provider.provider;
  }
}
