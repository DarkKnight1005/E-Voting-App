import 'package:flutter/material.dart';

class PasswordVisibilityNotifier extends ChangeNotifier {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
