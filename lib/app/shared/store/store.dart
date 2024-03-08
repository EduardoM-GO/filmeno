import 'package:flutter/foundation.dart';

abstract class Store<T extends Object> extends ChangeNotifier {
  T _state;
  bool _isDisposed;

  Store(this._state) : _isDisposed = false;

  T get state => _state;

  @protected
  void emit(T value) {
    if (value == _state) return;
    _state = value;

    if (_isDisposed) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
