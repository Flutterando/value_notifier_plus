import 'value_notifier_plus.dart';

abstract class ObserverPlus {
  void onChange<ValueNotifierPlusType extends ValueNotifierPlus>(
    ValueNotifierPlusType notifier,
    Object? state,
  );
}
