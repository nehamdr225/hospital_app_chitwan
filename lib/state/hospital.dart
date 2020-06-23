import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HospitalDataStore extends ChangeNotifier {
  handleInitialProfileLoad() {
    try {
      if (user == null) {
        final auth = AuthService();
        print('Bootstrapping data store\n');
        auth.getCurrentUID().then((value) {
          print('value $value');
          if (value != null) {
            DatabaseService.getHospitalData(value).then((userData) {
              if (userData.data != null) {
                user = userData.data;
                // getAvailableDoctors(userData.data['name']);
                uid = value;
                type = userData.data['role'];
                // notifyListeners();
              }
            }).catchError((err) {
              print(err);
            });
          }
        });
        getAvailableDoctors();
      }
    } catch (e) {}
  }

  String _id;
  String _userType;
  List _doctors;
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

  Map get user => _userData;

  set user(newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List get doctors => _doctors;

  set doctors(List newDoctors) {
    _doctors = newDoctors;
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

  void getAvailableDoctors() {
    DatabaseService.getDoctors().listen((QuerySnapshot onData) {
      if (onData.documents.length > 0) {
        final List newDoctorData = onData.documents.map<Map>((each) {
          final Map data = each.data;
          data['id'] = each.documentID;
          return data;
        }).toList();
        if (doctors == null) {
          doctors = newDoctorData;
        } else {
          newDoctorData.removeWhere((element) =>
              _doctors.firstWhere((doc) => doc['id'] == element['id']));
          _doctors.addAll(newDoctorData);
          notifyListeners();
        }
      }
    }, onError: (e) {
      print('Got doctor error\n $e');
    });
  }

  getOneDoctor({String id, String name}) {
    if (id != null) {
      return doctors.firstWhere((element) => element['id'] == id);
    }
    return doctors.firstWhere((element) => element['name'] == name);
  }

  Future<bool> verifyDoctor(String id) {
    return DatabaseService.markDoctorVerified(id);
  }

  updateDoctorValue(String id, String key, dynamic value) {
    final newVal = _doctors.map<Map>((e) {
      if (e['id'] == id) {
        final updatedData = e;
        updatedData[key] = value;
        return updatedData;
      }
      return e;
    }).toList();
    doctors = newVal;
  }

  clearState() {
    _id = null;
    _userData = null;
    _userType = null;
    setLocalUserData('userType', null);
    // _hospitals = null;
    notifyListeners();
  }
}
