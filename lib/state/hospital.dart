import 'dart:io';

import 'package:chitwan_hospital/models/Hospital.dart';
import 'package:chitwan_hospital/models/HospitalInquiry.dart';
import 'package:chitwan_hospital/models/HospitalPromotion.dart';
import 'package:chitwan_hospital/models/PCRAppintment.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        getPromotions();
        getInquiries();
        getPCR();
      }
    } catch (e) {}
  }

  List _doctors;
  Hospital _userData;
  List<HospitalPromotion> _promotions;
  List<HospitalInquiry> _inquiries;
  List<PCRAppointment> _appointments;

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

  List<HospitalPromotion> get promotions => _promotions;

  set promotions(List<HospitalPromotion> newPromotions) {
    _promotions = newPromotions;
    notifyListeners();
  }

  List<HospitalInquiry> get inquiries => _inquiries;

  set inquiries(List<HospitalInquiry> newinquiries) {
    _inquiries = newinquiries;
    notifyListeners();
  }

  List<PCRAppointment> get appointments => _appointments;

  set appointments(List<PCRAppointment> newappointments) {
    _appointments = newappointments;
    notifyListeners();
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

  void getPromotions() {
    DatabaseService.getPromotions(user.uid).listen((event) {
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

  void getPCR() {
    DatabaseService.getPCRHospitalAppointments().listen((event) {
      if (event.documents.length > 0) {
        final promoData = event.documents.map<PCRAppointment>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return PCRAppointment.fromJson(data);
        }).toList();
        appointments = promoData;
      }
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

  Future<bool> update(Map<String, String> data) async {
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

  Future<bool> setAppointmentStatus(String uid, dynamic status) async {
    bool value = await DatabaseService.setPCRAppointmentStatus(uid, status);
    // if (value) {
    //   final newAppointments = _appointments.map<PCRAppointment>((each) {
    //     if (each.id == uid) {
    //       final data = each;
    //       data.status = status;
    //       return data;
    //     }
    //     return each;
    //   }).toList();
    //   appointments = newAppointments;
    // }
    return value;
  }

  updateDepartments(Map data) {
    DatabaseService.updateHospitalData(user.uid, data);
  }

  createPromotion(Map<String, dynamic> data) {
    return DatabaseService.createPromotion(data);
  }

  archivePromotion(String documentId) {
    return DatabaseService.archivePromotion(documentId);
  }

  StorageUploadTask uploadFile(File file) {
    return DatabaseService.uploadFile(file, user.uid);
  }

  getInquiries() {
    if (inquiries == null || inquiries.length == 0) {
      DatabaseService.getInquiriesForHospital(user.uid).listen((event) {
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

  updateInquiryAnswer(String documentId, String answer) {
    DatabaseService.updateInquiryAnswer(documentId, answer);
  }

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
