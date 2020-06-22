import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HospitalDataStore extends ChangeNotifier {
  HospitalDataStore() {
    try {
      final auth = AuthService();
      print('Bootstrapping data store\n');
      auth.getCurrentUID().then((value) {
        print('value $value');
        if (value != null) {
          DatabaseService.getUserData(value).then((userData) {
            if (userData.data != null) {
              user = userData.data;
              // getAvailableDoctors(userData.data['name']);
              uid = value;
              type = userData.data['role'];
            }
          }).catchError((err) {
            print(err);
          });
        }
      });
    } catch (e) {}
  }

  String _id;
  String _userType;
  Map<String, dynamic> _userData;

  get uid => _id;

  set uid(userId) {
    _id = userId;
    notifyListeners();
  }

  get type => _userType;

  set type(userType) {
    _userType = userType;
  }

  get user => _userData;

  set user(newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  fetchUserData() {
    if (uid != null && type != null) {
      if (type == 'user') {
        DatabaseService.getUserData(uid).then((value) {
          if (value.data != null) {
            user = value.data;
          }
        }).catchError((err) {
          print(err);
        });
      }
    }
  }

  void getAvailableDoctors(String hospital) {
    if (hospital != null) {
      DatabaseService.getDoctors().listen((QuerySnapshot onData) {
        print(['Got doctor data\n', onData]);
      }, onError: (e) {
        print('Got doctor error\n $e');
      });
    }
  }
}
