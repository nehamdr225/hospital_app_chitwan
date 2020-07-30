import 'dart:io';

import 'package:eMed/models/Lab.dart';
import 'package:eMed/models/LabAppointment.dart';
import 'package:eMed/service/auth.dart';
import 'package:eMed/service/database.dart';
import 'package:eMed/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class LabDataStore extends ChangeNotifier {
  handleInitialProfileLoad() async {
    try {
      if (user == null) {
        final String value = await AuthService.getCurrentUID();
        if (value != null) {
          final DocumentSnapshot userData =
              await DatabaseService.getLabData(value);
          if (userData.data != null) {
            final json = userData.data;
            json['id'] = value;
            user = Laboratory.fromJson(json);
            getOrders();
          }
        }
      }
    } catch (e) {}
  }

  Laboratory _userData;
  List<LabAppointment> _orders;

  Laboratory get user => _userData;

  set user(Laboratory newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List<LabAppointment> get orders => _orders;

  set orders(List<LabAppointment> orderData) {
    _orders = orderData;
    notifyListeners();
  }

  addOrder(LabAppointment orderData) {
    _orders.add(orderData);
    notifyListeners();
  }

  Future<bool> update(Map<String, String> data) async {
    try {
      await DatabaseService.updateLabData(user.uid, data);
      final Map newUserData = {...user.toJson(), ...data};
      user = Laboratory.fromJson(newUserData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createOrder(Map<String, String> data) {
    return DatabaseService.createLabOrder(data);
  }

  getOrders() {
    if (orders == null) {
      DatabaseService.getLabOrders(user.uid).listen((event) {
        List newData = event.documents.map<LabAppointment>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return LabAppointment.fromJson(data);
        }).toList();
        orders = newData;
      });
    }
  }

  LabAppointment getOneOrder(String id) {
    return orders.firstWhere((element) => element.id == id);
  }

  Stream<QuerySnapshot> getUserInfo(String name) {
    return DatabaseService.getUserByName(name);
  }

  Future<bool> setOrderStatus(String uid, dynamic status) {
    return DatabaseService.updateLabOrderStatus(uid, status);
  }

  Future<bool> setOrderFile(String uid, String url) {
    return DatabaseService.updateLabOrderFile(uid, url);
  }

  setOrderRemark(String uid, String remark) {
    DatabaseService.updateLabOrderRemark(uid, remark).then((value) {
      if (value) {
        final newOrders = _orders.map<LabAppointment>((each) {
          if (each.id == uid) {
            final data = each;
            data.remark = remark;
            return data;
          }
          return each;
        }).toList();
        orders = newOrders;
      }
    });
  }

  StorageUploadTask uploadFile(File file, String uid) {
    return DatabaseService.uploadFile(file, uid);
  }

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
