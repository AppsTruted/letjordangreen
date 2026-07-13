import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {

  String _firstLetter = "";
  String _secondLetter = "";
  bool _isLoading = false ;
  bool _isDeleting = false;

  String get firstLetter => _firstLetter;

  String get secondLetter => _secondLetter;

  bool get isLoading => _isLoading;

  bool get isDeleting => _isDeleting;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set secondLetter(String value) {
    _secondLetter = value;
    notifyListeners();
  }

  set firstLetter(String value) {
    _firstLetter = value;
    notifyListeners();
  }

  setIsDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }
}