import 'dart:io';

import 'package:chitwan_hospital/models/Favourites.dart';
import 'package:chitwan_hospital/models/Hospital.dart';
import 'package:chitwan_hospital/models/HospitalInquiry.dart';
import 'package:chitwan_hospital/models/HospitalPromotion.dart';
import 'package:chitwan_hospital/models/Lab.dart';
import 'package:chitwan_hospital/models/LabAppointment.dart';
import 'package:chitwan_hospital/models/PharmacyAppointment.dart';
import 'package:chitwan_hospital/models/User.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
            data['id'] = userId;
            user = User.fromJson(data);
            getUserAppointments();
            getAvailableDoctors(null);
            getHospitals();
            getUserPrescriptions();
            getUserLabs();
            fetchMessages();
            getInquiries();
            getPromotions();
          }
        }
      }
    } catch (e) {}
  }

  User _userData;
  List<Hospital> _hospitals;
  List _appointments;
  List _doctors;
  List<PharmacyAppointment> _prescriptions;
  List<LabAppointment> _labs;
  List _messages;
  List _pharmacies;
  List<Laboratory> _laboratories;
  List<HospitalInquiry> _inquiries;
  List<HospitalPromotion> _promotions;
  List<Favourite> _favourites;

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

  List<PharmacyAppointment> get prescriptions => _prescriptions;

  set prescriptions(List<PharmacyAppointment> newData) {
    _prescriptions = newData;
    notifyListeners();
  }

  List<LabAppointment> get labs => _labs;

  set labs(List<LabAppointment> newData) {
    _labs = newData;
    notifyListeners();
  }

  List<Laboratory> get laboratories => _laboratories;

  set laboratories(List<Laboratory> newData) {
    _laboratories = newData;
    notifyListeners();
  }

  List get pharmacies => _pharmacies;

  set pharmacies(newData) {
    _pharmacies = newData;
    notifyListeners();
  }

  List<Hospital> get hospitals => _hospitals;

  set hospitals(List<Hospital> newData) {
    _hospitals = newData;
    notifyListeners();
  }

  List<HospitalInquiry> get inquiries => _inquiries;

  set inquiries(List<HospitalInquiry> newData) {
    _inquiries = newData;
    notifyListeners();
  }

  List<HospitalPromotion> get promotions => _promotions;

  set promotions(List<HospitalPromotion> newPromotions) {
    _promotions = newPromotions;
    notifyListeners();
  }

  List<Favourite> get favourites => _favourites;

  set favourites(List<Favourite> newfavourites) {
    _favourites = newfavourites;
    notifyListeners();
  }

  Future<Map> createMessageCollection(String docId, String docName) async {
    final document = await DatabaseService.createMessageDocument(
        user.uid, docId, user.name, docName);
    final data = document.documents[0].data;
    data['id'] = document.documents[0].documentID;
    final isThereAnEntry = _messages.any(
        (element) => element['uid'] == user.uid && element['docId'] == docId);
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

  listenToMessages(String docId) {
    DatabaseService.getMessages(docId).listen((event) {
      if (event.data.length > 0) {
        final data = event.data;
        data['id'] = event.documentID;
        final local =
            _messages.firstWhere((element) => element['id'] == data['id']);
        if (local != null &&
            local['conversations'].length < data['conversations'].length) {
          final changedData = _messages.map((e) {
            if (e['id'] == data['id']) return data;
            return e;
          }).toList();
          _messages = changedData;
          notifyListeners();
        }
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
        // print('New msg data $data');
        _messages.addAll(data);
        notifyListeners();
        return;
      }
      // print('New msg data $data');
      messages = data;
      return;
    });
  }

  sendMessage(Map data, String docId) {
    DatabaseService.updateMessages(docId, data);
  }

  pushMessageLocally(Map data, String docId) {
    int i = 0;
    for (final element in _messages) {
      if (element['id'] == docId) {
        _messages[i]['conversations'].add(data);
        notifyListeners();
        break;
      }
      i++;
    }
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

  Future<bool> update(Map<String, String> data) async {
    try {
      await DatabaseService.updateUserData(user.uid, data);
      final Map newData = {...user.toJson(), ...data};
      final User newUser = User.fromJson(newData);
      user = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
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
          newDoctorData.removeWhere((element) => _doctors.firstWhere(
                    (doc) => doc['id'] == element['id'],
                    orElse: () => null,
                  ) !=
                  null
              ? true
              : false);
          if (newDoctorData.length > 0) {
            _doctors.addAll(newDoctorData);
            notifyListeners();
          }
        }
      }, onError: (e) {
        print('Got doctor error\n $e');
      });
    }
  }

  getPharmacies() {
    if (pharmacies == null || pharmacies.length == 0) {
      DatabaseService.getPharmacies().listen((event) {
        if (event.documents.length > 0) {
          final pharmacyData = event.documents
              .map((e) => {...e.data, 'id': e.documentID})
              .toList();
          pharmacies = pharmacyData;
        }
      });
    }
  }

  void getLabs() {
    if (pharmacies == null || pharmacies.length == 0) {
      DatabaseService.getLabs().listen((event) {
        if (event.documents.length > 0) {
          final labData = event.documents
              .map<Laboratory>(
                  (e) => Laboratory.fromJson({...e.data, 'id': e.documentID}))
              .toList();
          laboratories = labData;
        }
      });
    }
  }

  getHospitals() {
    if (hospitals == null || hospitals.length == 0) {
      DatabaseService.getHospitals().listen((event) {
        if (event.documents.length > 0) {
          final hospitalData = event.documents
              .map<Hospital>(
                  (e) => Hospital.fromJson({...e.data, 'id': e.documentID}))
              .toList();
          hospitals = hospitalData;
        }
      });
    }
  }

  getInquiries() {
    if (inquiries == null || inquiries.length == 0) {
      DatabaseService.getInquiries(user.uid).listen((event) {
        if (event.documents.length > 0) {
          final inquiryData = event.documents
              .map<HospitalInquiry>((e) =>
                  HospitalInquiry.fromJson({...e.data, 'id': e.documentID}))
              .toList();
          inquiries = inquiryData;
        }
      });
    }
  }

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
      final List<PharmacyAppointment> addData =
          data.documents.map<PharmacyAppointment>((e) {
        final Map thisData = e.data;
        thisData['id'] = e.documentID;
        return PharmacyAppointment.fromJson(thisData);
      }).toList();
      prescriptions = addData;
    });
  }

  getUserLabs() {
    DatabaseService.getUserLabOrders(user.uid).listen((data) {
      final List addData = data.documents.map<LabAppointment>((e) {
        final Map thisData = e.data;
        thisData['id'] = e.documentID;
        return LabAppointment.fromJson(thisData);
      }).toList();
      labs = addData;
    });
  }

  getOneAppointment(String id) {
    return _appointments.firstWhere((element) => element['id'] == id);
  }

  Future<bool> orderMedicine(Map<String, String> data) async {
    final result = await DatabaseService.createPharmacyOrder(data);
    return result;
  }

  StorageUploadTask uploadFile(File file, String uid) {
    return DatabaseService.uploadFile(file, uid);
  }

  Future<bool> createLabOrder(Map<String, String> data) {
    return DatabaseService.createLabOrder(data);
  }

  createInquiry(Map<String, String> data) {
    return DatabaseService.createInquiry(data);
  }

  void getPromotions() {
    DatabaseService.getPromotionsForUser().listen((event) {
      if (event.documents.length > 0) {
        final promoData = event.documents.map<HospitalPromotion>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return HospitalPromotion.fromJson(data);
        }).toList();
        promotions = promoData;
      }
    });
  }

  void getFavourites() {
    DatabaseService.getFavourites(user.uid).listen((event) {
      if (event.documents.length > 0) {
        final favData = event.documents.map<Favourite>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return Favourite.fromJson(data);
        }).toList();
        favourites = favData;
      }
    });
  }

  Future<void> deleteFavourite(String documentId) {
    return DatabaseService.deleteFavourite(documentId);
  }

  clearState() {
    _userData = null;
    // _hospitals = null;
    _appointments = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
