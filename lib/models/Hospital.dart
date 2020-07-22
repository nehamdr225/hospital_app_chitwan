import 'package:chitwan_hospital/models/User.dart';

abstract class HospitalModel extends UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;

  bool isVerified;
  List departments;
}

class Hospital implements HospitalModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;

  bool isVerified;
  List departments;

  Hospital.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'],
        this.role = json['role'],
        this.address = json['address'] ?? null,
        this.isVerified = json['isVerified'] ?? null,
        this.departments = json['departments'] ?? null;

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        if (address != null) 'address': address,
        if (isVerified != null) 'isVerified': isVerified,
        if (departments != null) 'departments': departments,
      };
}
