import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDataStore extends ChangeNotifier {
  UserDataStore() {
    try {
      final auth = AuthService();
      print('Bootstrapping data store\n');
      auth.getCurrentUID().then((value) {
        print('value $value');
        if (value != null) {
          DatabaseService.getUserData(value).then((userData) {
            if (userData.data != null) {
              user = userData.data;
              uid = value;
              type = userData.data['role'];
            }
          }).catchError((err) {
            print(err);
          });
        }
      });
      getAvailableHospitals();
    } catch (e) {}
  }

  String _id;
  String _userType;
  Map<String, dynamic> _userData;
  List _hospitals;
  List _appointments;

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

  get hospitals => _hospitals;

  set hospitals(newHospitalData) {
    _hospitals = newHospitalData;
    notifyListeners();
  }

  get appointments => _appointments;

  set appointments(newAppointmentData) {
    _appointments = newAppointmentData;
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

  void getAvailableHospitals() {
    DatabaseService.getHospitals().listen((QuerySnapshot onData) {
      print(['Got hospital data\n']);
      final List allHospitals = onData.documents.map<Map>((element) {
        final Map data = element.data;
        data['id'] = element.documentID;
        return data;
      }).toList();
      allHospitals.removeWhere((element) => element['name'] == null);
      if (hospitals != null) {
        hospitals.addAll(allHospitals);
      } else {
        hospitals = allHospitals;
      }
    }, onError: (e) {
      print('Got hospital error\n $e');
    });
  }

  Future createAppointment(Map data) async {
    return DatabaseService.createAppointment(data);
  }

  getUserAppointments() {
    DatabaseService.getAppointments(uid).then((value) {
      print(value.data);
    });
  }
}
