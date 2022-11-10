import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get getAuthState => _isUserLoggedIn;

  void changeLogState() {
    _isUserLoggedIn = !_isUserLoggedIn;
    notifyListeners();
  }
}
