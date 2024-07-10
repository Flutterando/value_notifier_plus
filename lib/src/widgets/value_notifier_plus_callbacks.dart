import 'package:flutter/widgets.dart';

typedef ValueNotifierPlusListenerCallback<S> = void Function(
  BuildContext context,
  S state,
);

typedef ValueNotifierPlusWidgetBuilder<S> = Widget Function(
  BuildContext context,
  S state,
);
