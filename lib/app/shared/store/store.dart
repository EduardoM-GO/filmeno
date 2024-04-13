import 'package:flutter/foundation.dart';

abstract base class Store<T extends Object> extends ChangeNotifier {
  T _state;
  @visibleForTesting
  bool isDisposed;

  Store(this._state) : isDisposed = false;

  T get state => _state;

  @protected
  void emit(T value) {
    if (value == _state) return;
    _state = value;

    if (isDisposed) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
