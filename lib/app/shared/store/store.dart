import 'package:flutter/foundation.dart';

abstract class Store<T extends Object> extends ChangeNotifier {
  T _state;

  Store(this._state);

  T get state => _state;
  
  @protected
  void emit(T value) {
    if (value == _state) return;
    _state = value;
    notifyListeners();
  }
}
