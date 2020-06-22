import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataStore extends ChangeNotifier {
  SharedPreferences _storage;
  String _userType;

  AppDataStore() {
    initialSetup();
  }

  initialSetup() {
    SharedPreferences.getInstance().then((value) {
      _storage = value;
      notifyListeners();
      try {
        _userType = value.getString('userType');
        notifyListeners();
      } catch (err) {
        print(err);
      }
    }).catchError((err) => print(err));
  }

  get storage => _storage;

  get userType => _userType;

  set userType(String type) {
    SharedPreferences.getInstance().then((value) {
      _userType = type;
      _storage.setString('userType', type);
    });
  }
}
