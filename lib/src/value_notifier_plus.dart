import 'package:flutter/foundation.dart';

import 'observer_plus.dart';

class ValueNotifierPlus<State> extends ChangeNotifier implements Listenable {
  static ObserverPlus? observer;

  ValueNotifierPlus(this._state) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  State get state => _state;

  State _state;

  void emit(State state) {
    if (_state != state) {
      _state = state;
      _notify();
    }
  }

  void close() {
    dispose();
  }

  void _notify() {
    _notifyObserver();
    notifyListeners();
  }

  void _notifyObserver() {
    if (observer != null) {
      observer!.onChange(this, _state);
    }
  }

  // Function debounceAndDistinct(Function func, Duration duration) {
  //   Timer? timer;
  //   dynamic lastValue;

  //   return (State) {
  //     if (State != lastValue) {
  //       if (timer != null) {
  //         timer!.cancel();
  //       }

  //       lastValue = State;
  //       timer = Timer(duration, () => func(State));
  //     }
  //   };
  // }

  // Function distinct(Function func) {
  //   dynamic lastValue;

  //   return (State) {
  //     if (State != lastValue) {
  //       lastValue = State;
  //       func(State);
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
