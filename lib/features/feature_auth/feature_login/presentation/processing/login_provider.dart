import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier, DiagnosticableTreeMixin  {


  bool _passwordVisible = true;

  bool get passwordVisible => _passwordVisible;



  setPasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }


}