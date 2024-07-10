import 'package:flutter/widgets.dart';

import '../value_notifier_plus.dart';

class ValueNotifierPlusProvider<T extends ValueNotifierPlus<Object?>>
    extends StatefulWidget {
  const ValueNotifierPlusProvider({
    required this.notifier,
    required this.builder,
    super.key,
  });
  final WidgetBuilder builder;
  final T notifier;

  @override
  State<ValueNotifierPlusProvider<T>> createState() =>
      _ValueNotifierPlusProviderState<T>();

  static T? of<T extends ValueNotifierPlus<Object?>>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        _ValueNotifierPlusProviderInherited<T>>();
    return provider?.notifier;
  }
}

class _ValueNotifierPlusProviderState<T extends ValueNotifierPlus<Object?>>
    extends State<ValueNotifierPlusProvider<T>> {
  @override
  void dispose() {
    widget.notifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ValueNotifierPlusProviderInherited<T>(
      notifier: widget.notifier,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
  }
}

class _ValueNotifierPlusProviderInherited<T> extends InheritedWidget {
  const _ValueNotifierPlusProviderInherited({
    required super.child,
    required this.notifier,
  });
  final T notifier;
  // coverage:ignore-start

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
  // coverage:ignore-end
}

extension ValueNotifierPlusExtension on BuildContext {
  T? of<T extends ValueNotifierPlus<Object?>>() {
    final provider = dependOnInheritedWidgetOfExactType<
        _ValueNotifierPlusProviderInherited<T>>();
    if (provider == null) {
      throw FlutterError('No ValueNotifierPlusProvider<$T> found in context');
    }
    return provider.notifier;
  }
}
