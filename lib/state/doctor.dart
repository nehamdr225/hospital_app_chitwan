import 'package:chitwan_hospital/models/Doctor.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/cupertino.dart';

class DoctorDataStore extends ChangeNotifier {
  handleInitialProfileLoad() async {
    try {
      if (user == null) {
        final userId = await AuthService.getCurrentUID();
        if (userId != null) {
          final userData = await DatabaseService.getDoctorData(userId);
          if (userData.data != null) {
            final data = userData.data;
            data['id'] = userData.documentID;
            user = Doctor.fromJson(data);
            getAppointments();
            fetchMessages();
          }
        }
      }
    } catch (e) {}
  }

  Doctor _userData;
  List hospitals;
  List<Map> _appointments;
  List _messages;

  List get messages => _messages;

  set messages(messageList) {
    _messages = messageList;
    notifyListeners();
  }

  Doctor get user => _userData;

  set user(Doctor newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List<Map> get appointments => _appointments;

  set appointments(newUserData) {
    _appointments = newUserData;
    notifyListeners();
  }

  Future<Map> createMessageCollection(String userId, String userName) async {
    final document = await DatabaseService.createMessageDocument(
        userId, user.uid, userName, user.name);
    final data = document.documents[0].data;
    data['id'] = document.documents[0].documentID;
    final isThereAnEntry = _messages.any(
        (element) => element['uid'] == userId && element['docId'] == user.uid);
    if (!isThereAnEntry) {
      _messages.add(data);
      notifyListeners();
    }
    return data;
  }

  getSpecificMessages(String userId, String doctorId) {
    if (messages == null || messages.length == 0) return null;
    return messages.firstWhere(
      (element) => element['uid'] == userId && element['docId'] == doctorId,
      orElse: () => null,
    );
  }

  listenToMessages(String documentId) {
    DatabaseService.getMessages(documentId).listen((event) {
      if (event.data.length > 0) {
        final data = event.data;
        data['id'] = event.documentID;
        final changedData = _messages.map((e) {
          if (e['id'] == data['id']) return data;
          return e;
        });
        _messages = changedData;
        notifyListeners();
      }
    });
  }

  fetchMessages() {
    DatabaseService.getMessagesDoctor(user.uid).listen((event) {
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
      messages = data;
      return;
    });
  }

  sendMessage(Map data, String documentId) {
    DatabaseService.updateMessages(documentId, data);
  }

  pushMessageLocally(Map data, String documentId) {
    int i = 0;
    for (final element in _messages) {
      if (element['id'] == documentId) {
        _messages[i]['conversations'].add(data);
        notifyListeners();
        break;
      }
      i++;
    }
  }

  fetchUserData(String uid) {
    if (uid != null) {
      DatabaseService.getDoctorData(uid).then((value) {
        if (value.data != null) {
          final data = value.data;
          data['id'] = value.documentID;
          user = Doctor.fromJson(data);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<bool> update(data) async {
    try {
      await DatabaseService.updateDoctorData(user.uid, data);
      final Map newData = {...user.toJson(), ...data};
      final Doctor newUser = Doctor.fromJson(newData);
      user = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getHospitals() {
    if (hospitals == null)
      DatabaseService.getHospitals().listen((onData) {
        List newData = onData.documents.map<Map>((e) => e.data).toList();
        hospitals = newData;
      });
  }

  getAppointments() {
    if (appointments == null) {
      DatabaseService.getDoctorAppointments(user.uid).listen((onData) {
        List newData = onData.documents.map<Map>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return data;
        }).toList();
        appointments = newData;
      });
    }
  }

  Future<bool> setAppointmentStatus(String uid, dynamic status) async {
    bool value = await DatabaseService.setAppointmentStatus(uid, status);
    if (value) {
      final newAppointments = _appointments.map<Map>((each) {
        if (each['id'] == uid) {
          final data = each;
          data['status'] = status;
          return data;
        }
        return each;
      }).toList();
      appointments = newAppointments;
    }
    return value;
  }

  Future<bool> setDiagnosis(String uid, List data) async {
    try {
      bool result = await DatabaseService.setDiagnosis(uid, data);
      final newAppointments = _appointments.map<Map>((e) {
        if (e['id'] == uid) {
          final newData = e;
          newData['diagnosis'] = data;
          return newData;
        }
        return e;
      }).toList();
      appointments = newAppointments;
      return result;
    } catch (e) {
      return false;
    }
  }

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    // _hospitals = null;
    notifyListeners();
  }
}
