import 'package:chitwan_hospital/models/Lab.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map> _orders;

  Laboratory get user => _userData;

  set user(Laboratory newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List get orders => _orders;

  set orders(orderData) {
    _orders = orderData;
    notifyListeners();
  }

  addOrder(Map orderData) {
    _orders.add(orderData);
    notifyListeners();
  }

  Future<bool> update(data) async {
    try {
      await DatabaseService.updateLabData(user.uid, data);
      final Map newUserData = {...user.toJson(), ...data};
      user = Laboratory.fromJson(newUserData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createOrder(Map data) {
    return DatabaseService.createLabOrder(data);
  }

  getOrders() {
    if (orders == null) {
      DatabaseService.getLabOrders().then((onData) {
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

  Stream<QuerySnapshot> getUserInfo(String name) {
    return DatabaseService.getUserByName(name);
  }

  Future setOrderStatus(String uid, dynamic status) {
    return DatabaseService.updateLabOrderStatus(uid, status).then((value) {
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
    DatabaseService.updateLabOrderRemark(uid, remark).then((value) {
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

  clearState() {
    _userData = null;
    setLocalUserData('userType', null);
    notifyListeners();
  }
}
