import 'package:chitwan_hospital/models/Hospital.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HospitalDataStore extends ChangeNotifier {
  handleInitialProfileLoad() async {
    try {
      if (user == null) {
        final String value = await AuthService.getCurrentUID();
        if (value != null) {
          final DocumentSnapshot userData =
              await DatabaseService.getHospitalData(value);
          if (userData.data != null) {
            final json = userData.data;
            json['id'] = value;
            user = Hospital.fromJson(json);
          }
        }
        getAvailableDoctors();
      }
    } catch (e) {}
  }

  List _doctors;
  Hospital _userData;

  Hospital get user => _userData;

  set user(Hospital newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List get doctors => _doctors;

  set doctors(List newDoctors) {
    _doctors = newDoctors;
    notifyListeners();
  }

  // fetchUserData() {
  //   if (user.uid != null && user.role != null) {
  //     if (user.role == 'user') {
  //       DatabaseService.getUserData(uid).then((value) {
  //         if (value.data != null) {
  //           user = value.data;
  //         }
  //       }).catchError((err) {
  //         print(err);
  //       });
  //     }
  //   }
  // }

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
          newDoctorData.removeWhere((element) {
            final firstVal =
                _doctors.firstWhere((doc) => doc['id'] == element['id']);
            return firstVal != null ? true : false;
          });
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

  Future<bool> deleteDoctor(String id) async {
    bool status = await DatabaseService.deleteDoctor(id);
    if (status) {
      _doctors.removeWhere((element) => element['id'] == id);
      notifyListeners();
      return true;
    }
    return false;
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

  Future<bool> update(data) async {
    try {
      await DatabaseService.updateHospitalData(user.uid, data);
      final Map newData = {...user.toJson(), ...data};
      final Hospital newUser = Hospital.fromJson(newData);
      user = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  updateDepartments(Map data) {
    DatabaseService.updateHospitalData(user.uid, data);
  }

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
