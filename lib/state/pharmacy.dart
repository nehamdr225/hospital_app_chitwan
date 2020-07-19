import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PharmacyDataStore extends ChangeNotifier {
  handleInitialProfileLoad() {
    try {
      if (user == null) {
        print('Bootstrapping data store\n');
        AuthService.getCurrentUID().then((value) {
          print('value $value');
          if (value != null) {
            DatabaseService.getPharmacyData(value).then((userData) {
              print(userData.data);
              if (userData.data != null) {
                user = userData.data;
                uid = value;
                type = userData.data['role'];
                getOrders();
              }
            }).catchError((err) {
              print(err);
            });
          }
        });
      }
    } catch (e) {}
  }

  String _id;
  String _userType;
  Map<String, dynamic> _userData;
  List hospitals;
  List<Map> _orders;

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

  List get orders => _orders;

  set orders(orderData) {
    _orders = orderData;
    notifyListeners();
  }

  Future<bool> update(data) async {
    try {
      await DatabaseService.updatePharmacyData(uid, data);
      _userData.addAll(data);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getOrders() {
    if (orders == null) {
      DatabaseService.getPharmacyOrders(uid).then((onData) {
        List newData = onData.documents.map<Map>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return data;
        }).toList();
        orders = newData;
      });
    }
  }

  getOneOrder(String id) {
    return orders.firstWhere((element) => element['id'] == id);
  }

  Future<DocumentSnapshot> getUserInfo(String id) async {
    return DatabaseService.getUserData(id);
  }

  Future setOrderStatus(String uid, dynamic status) {
    return DatabaseService.updateOrderStatus(uid, status).then((value) {
      if (value) {
        final newOrders = _orders.map<Map>((each) {
          if (each['id'] == uid) {
            final data = each;
            data['status'] = status;
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
        final newOrders = _orders.map<Map>((each) {
          if (each['id'] == uid) {
            final data = each;
            data['remark'] = remark;
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
    _id = null;
    _userData = null;
    _userType = null;
    setLocalUserData('userType', null);
    // _hospitals = null;
    notifyListeners();
  }
}
