import 'package:chitwan_hospital/models/User.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDataStore extends ChangeNotifier {
  handleInitialProfileLoad() async {
    try {
      if (user == null) {
        final String userId = await AuthService.getCurrentUID();
        if (userId != null) {
          final userData = await DatabaseService.getUserData(userId);
          if (userData.data != null) {
            final data = userData.data;
            data['uid'] = userId;
            user = User.fromJson(data);
            getUserAppointments();
            getAvailableDoctors(null);
            getUserPrescriptions();
            getUserLabs();
            fetchMessages();
          }
        }
      }
    } catch (e) {}
  }

  User _userData;
  // List _hospitals;
  List _appointments;
  List _doctors;
  List _prescriptions;
  List _labs;
  List _messages;

  List get messages => _messages;

  set messages(messageList) {
    _messages = messageList;
    notifyListeners();
  }

  User get user => _userData;

  set user(User newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  // List get hospitals => _hospitals;

  // set hospitals(newHospitalData) {
  //   _hospitals = newHospitalData;
  //   notifyListeners();
  // }

  List get appointments => _appointments;

  set appointments(newAppointmentData) {
    _appointments = newAppointmentData;
    notifyListeners();
  }

  List get doctors => _doctors;

  set doctors(newDoctorData) {
    _doctors = newDoctorData;
    notifyListeners();
  }

  List get prescriptions => _prescriptions;

  set prescriptions(newData) {
    _prescriptions = newData;
    notifyListeners();
  }

  List get labs => _labs;

  set labs(newData) {
    _labs = newData;
    notifyListeners();
  }

  createMessageCollection(String docId, String docName) {
    DatabaseService.createMessageDocument(user.uid, docId, user.name, docName)
        .then((value) {
      if (_messages != null) {
        final isThereAnEntry = _messages.any((element) =>
            element['uid'] == user.uid && element['docId'] == docId);
        if (isThereAnEntry != null) return;
        _messages.add({
          'uid': user.uid,
          'docId': docId,
          'user': user.name,
          'doctor': docName,
          'conversations': []
        });
      } else
        _messages = [
          {
            'uid': user.uid,
            'docId': docId,
            'user': user.name,
            'doctor': docName,
            'conversations': []
          }
        ];
      notifyListeners();
    });
  }

  getSpecificMessages(String userId, String doctorId) {
    if (messages == null || messages.length == 0) return null;
    return messages.firstWhere(
      (element) => element['uid'] == userId && element['docId'] == doctorId,
      orElse: () => null,
    );
  }

  listenToMessages(String docId) {
    DatabaseService.getMessages(user.uid, docId).listen((event) {
      if (event.documents.length > 0) {
        final data = event.documents[0].data;
        data['id'] = event.documents[0].documentID;
        _messages.map((e) {
          if (e['id'] == data['id']) return data;
          return e;
        });
        notifyListeners();
      }
    });
  }

  fetchMessages() {
    DatabaseService.getMessagesUser(user.uid).listen((event) {
      final data = event.documents.map((e) {
        final Map messageData = e.data;
        messageData['id'] = e.documentID;
        return messageData;
      }).toList();
      if (messages != null) {
        data.removeWhere((element) {
          final match = _messages.firstWhere(
            (check) {
              return check['uid'] == element['uid'] &&
                  check['docId'] == element['docId'];
            },
            orElse: () => null,
          );

          if (match != null) return true;
          return false;
        });
        _messages.addAll(data);
        notifyListeners();
        return;
      }
      print('Message Data');
      print(data);
      messages = data;
      return;
    });
  }

  sendMessage(Map data, String docId) {
    DatabaseService.updateMessages(docId, data).then((value) {
      final mapped = _messages.map((e) {
        if (e['id'] == docId) {
          final newData = e;
          newData['conversations'].add(data);
          return data;
        }
        return e;
      }).toList();
      _messages = mapped;
      notifyListeners();
    });
  }

  fetchUserData(uid) {
    if (user == null) {
      DatabaseService.getUserData(uid).then((value) {
        if (value.data != null) {
          final data = value.data;
          data['uid'] = uid;
          user = User.fromJson(data);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  void getAvailableDoctors(String hospital) {
    if (hospital != null) {
      DatabaseService.getDoctors().listen((QuerySnapshot onData) {
        print(['Got doctor data\n', onData]);
      }, onError: (e) {
        print('Got doctor error\n $e');
      });
    } else {
      DatabaseService.getDoctors().listen((QuerySnapshot onData) {
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
      }, onError: (e) {
        print('Got doctor error\n $e');
      });
    }
  }

  // void getAvailableHospitals() {
  //   DatabaseService.getHospitals().listen((QuerySnapshot onData) {
  //     print(['Got hospital data\n']);
  //     final List allHospitals = onData.documents.map<Map>((element) {
  //       final Map data = element.data;
  //       data['id'] = element.documentID;
  //       return data;
  //     }).toList();
  //     if (hospitals != null) {
  //       allHospitals.removeWhere((element) =>
  //           hospitals.any((hosp) => element['name'] == hosp['name']));
  //       hospitals.addAll(allHospitals);
  //     } else {
  //       hospitals = allHospitals;
  //     }
  //   }, onError: (e) {
  //     print('Got hospital error\n $e');
  //   });
  // }

  Future createAppointment(Map data) async {
    return DatabaseService.createAppointment(data);
  }

  getUserAppointments() {
    final result = DatabaseService.getAppointments(user.uid);
    result.listen((data) {
      final List addData = data.documents.map<Map>((e) {
        final Map thisdata = e.data;
        thisdata['id'] = e.documentID;
        return thisdata;
      }).toList();
      if (appointments != null) {
        addData.removeWhere((element) =>
            _appointments.any((check) => check['id'] == element['id']));
        _appointments.addAll(addData);
        notifyListeners();
      } else {
        appointments = addData;
      }
    }, onError: (err) {
      print(err);
    });
  }

  getUserPrescriptions() {
    DatabaseService.getUserPharmacyOrders(user.uid).listen((data) {
      final List addData = data.documents.map((e) {
        final Map thisData = e.data;
        thisData['id'] = e.documentID;
        return thisData;
      }).toList();
      prescriptions = addData;
    });
  }

  getUserLabs() {
    DatabaseService.getUserLabOrders(user.uid).listen((data) {
      final List addData = data.documents.map((e) {
        final Map thisData = e.data;
        thisData['id'] = e.documentID;
        return thisData;
      }).toList();
      labs = addData;
    });
  }

  getOneAppointment(String id) {
    return _appointments.firstWhere((element) => element['id'] == id);
  }

  Future<bool> orderMedicine(String aid, String medicine, String title) async {
    final result =
        await DatabaseService.createPharmacyOrder(user.uid, aid, medicine);
    return result;
  }

  clearState() {
    _userData = null;
    // _hospitals = null;
    _appointments = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
