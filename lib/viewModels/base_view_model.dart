import 'package:flutter/material.dart';

abstract class BaseViewModel with ChangeNotifier {
  //TODO if you need handle the base progress changes or errors provide setters getters for your values and notify your listener

  bool _busy = false;
  String _error = '';

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void setBusyWithOutNotify(bool value) {
    _busy = value;
  }

  bool disposed = false;

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
