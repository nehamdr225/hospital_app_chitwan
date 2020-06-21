import 'package:flutter/cupertino.dart';

class DataStore extends ChangeNotifier {
  Map<String, dynamic> _userData;

  get user => _userData;

  set user(newUserData) {
    _userData = newUserData;
    notifyListeners();
  }
}
