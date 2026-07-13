import 'package:flutter/foundation.dart';

class SignupProvider with ChangeNotifier, DiagnosticableTreeMixin  {


  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  bool get passwordVisible => _passwordVisible;


  bool get confirmPasswordVisible => _confirmPasswordVisible;

  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  setConfirmPasswordVisible() {
    _confirmPasswordVisible = !_confirmPasswordVisible;
    notifyListeners();
  }
}