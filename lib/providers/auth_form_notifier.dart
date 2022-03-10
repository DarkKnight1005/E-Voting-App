import 'package:flutter/material.dart';

class AuthFormNotifier extends ChangeNotifier {
  bool _isLoginForm = false;

bool get isLoginForm => _isLoginForm;


void changeFormView(){
_isLoginForm = !_isLoginForm;
notifyListeners();
}
}