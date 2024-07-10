import 'package:flutter/foundation.dart';

import 'value_notifier_plus_observer.dart';

class ValueNotifierPlus<State> extends ValueNotifier<State> {
  ValueNotifierPlus(super.initialState);
  static ValueNotifierPlusObserver? observer;

  State get state => value;

  void emit(State state) {
    if (value != state) {
      value = state;
      _notifyObserver();
    }
  }

  void close() {
    dispose();
  }

  void _notifyObserver() {
    if (observer != null) {
      observer!.onChange(this, value);
    }
  }
}
