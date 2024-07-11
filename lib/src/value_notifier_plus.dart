import 'package:flutter/foundation.dart';

import 'value_notifier_plus_observer.dart';

class ValueNotifierPlus<State> extends ValueNotifier<State> {
  static ValueNotifierPlusObserver? observer;

  ValueNotifierPlus(State value) : super(value);

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

  // Function debounceAndDistinct(Function func, Duration duration) {
  //   Timer? timer;
  //   dynamic lastValue;

  //   return (value) {
  //     if (value != lastValue) {
  //       if (timer != null) {
  //         timer!.cancel();
  //       }

  //       lastValue = value;
  //       timer = Timer(duration, () => func(value));
  //     }
  //   };
  // }

  // Function distinct(Function func) {
  //   dynamic lastValue;

  //   return (value) {
  //     if (value != lastValue) {
  //       lastValue = value;
  //       func(value);
  //     }
  //   };
  // }

  // Function debounce(VoidCallback func, Duration duration) {
  //   Timer? timer;

  //   return () {
  //     if (timer != null) {
  //       timer!.cancel();
  //     }

  //     timer = Timer(duration, func);
  //   };
  // }
}
