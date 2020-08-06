import 'package:chitwan_hospital/models/Pharmacy.dart';
import 'package:chitwan_hospital/models/PharmacyAppointment.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PharmacyDataStore extends ChangeNotifier {
  handleInitialProfileLoad() async {
    try {
      if (user == null) {
        final String value = await AuthService.getCurrentUID();
        if (value != null) {
          final DocumentSnapshot userData =
              await DatabaseService.getPharmacyData(value);
          if (userData.data != null) {
            final json = userData.data;
            json['id'] = value;
            user = Pharmacy.fromJson(json);
            getOrders();
          }
        }
      }
    } catch (e) {}
  }

  Pharmacy _userData;
  List hospitals;
  List<PharmacyAppointment> _orders;

  Pharmacy get user => _userData;

  set user(Pharmacy newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List<PharmacyAppointment> get orders => _orders;

  set orders(List<PharmacyAppointment> orderData) {
    _orders = orderData;
    notifyListeners();
  }

  Future<bool> update(Map<String, String> data) async {
    try {
      await DatabaseService.updatePharmacyData(user.uid, data);
      final newData = {...user.toJson(), ...data};
      user = Pharmacy.fromJson(newData);
      return true;
    } catch (e) {
      return false;
    }
  }

  getOrders() {
    if (orders == null) {
      DatabaseService.getPharmacyOrders(user.uid).then((onData) {
        List<PharmacyAppointment> newData =
            onData.documents.map<PharmacyAppointment>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return PharmacyAppointment.fromJson(data);
        }).toList();
        orders = newData;
      });
    }
  }

  PharmacyAppointment getOneOrder(String id) {
    return orders.firstWhere((element) => element.id == id);
  }

  Future<DocumentSnapshot> getUserInfo(String id) async {
    return DatabaseService.getUserData(id);
  }

  Future setOrderStatus(String uid, dynamic status) {
    return DatabaseService.updateOrderStatus(uid, status).then((value) {
      if (value) {
        final newOrders = _orders.map<PharmacyAppointment>((each) {
          if (each.id == uid) {
            final data = each;
            data.status = status;
            return data;
          }
          return each;
        }).toList();
        orders = newOrders;
      }
      return null;
    });
  }

  setOrderRemark(String uid, String remark) {
    DatabaseService.updateOrderRemark(uid, remark).then((value) {
      if (value) {
        final newOrders = _orders.map<PharmacyAppointment>((each) {
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

  Future<DocumentSnapshot> getAppointment(String id) {
    return DatabaseService.getOneAppointment(id);
  }

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    // _hospitals = null;
    notifyListeners();
  }
}
