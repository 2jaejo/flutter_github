import 'package:flutter/cupertino.dart';

class LoginState with ChangeNotifier {
  String _login = 'loading';
  String get log => _login;
  setLog(String status) {
    _login = status;
    notifyListeners();
  }
}
