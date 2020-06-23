import 'package:shared_preferences/shared_preferences.dart';

getLocalUserData(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  } catch (e) {
    return null;
  }
}

setLocalUserData(String key, dynamic value) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  } catch (e) {}
}
