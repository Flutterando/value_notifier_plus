import 'package:flutter/widgets.dart';

typedef ListenerCallbackPlus<S> = void Function(
  BuildContext context,
  S state,
);

typedef WidgetBuilderPlus<S> = Widget Function(
  BuildContext context,
  S state,
);
