import 'package:flutter/widgets.dart';

class PlusProvider<T> extends StatefulWidget {
  const PlusProvider({
    required this.provider,
    required this.child,
    super.key,
  });

  final Widget child;
  final T provider;

  @override
  State<PlusProvider<T>> createState() => _PlusProviderState<T>();

  static T? of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_PlusProviderInherited<T>>();
    return provider?.provider;
  }
}

class _PlusProviderState<T> extends State<PlusProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _PlusProviderInherited<T>(
      provider: widget.provider,
      child: widget.child,
    );
  }
}

class _PlusProviderInherited<T> extends InheritedWidget {
  const _PlusProviderInherited({
    required super.child,
    required this.provider,
  });

  final T provider;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

extension PlusProviderExtension on BuildContext {
  T of<T>() {
    final provider =
        dependOnInheritedWidgetOfExactType<_PlusProviderInherited<T>>();
    if (provider == null) {
      throw FlutterError('No PlusProvider<$T> found in context');
    }
    return provider.provider;
  }
}
