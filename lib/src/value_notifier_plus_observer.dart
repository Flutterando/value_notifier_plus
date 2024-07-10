import 'value_notifier_plus.dart';

abstract class ValueNotifierPlusObserver {
  void onChange<ValueNotifierPlusType extends ValueNotifierPlus>(
    ValueNotifierPlusType notifier,
    Object? state,
  );
}
