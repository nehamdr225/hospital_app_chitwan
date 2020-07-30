import 'package:eMed/models/User.dart';

abstract class HospitalModel extends UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;

  bool isVerified;
  String departments;
  String about;
}

class Hospital implements HospitalModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;
  String address;

  bool isVerified;
  String departments;
  String about;

  Hospital.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'],
        this.role = json['role'],
        this.address = json['address'],
        this.isVerified = json['isVerified'],
        this.departments = json['departments'],
        this.about = json['about'];

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        if (address != null) 'address': address,
        if (isVerified != null) 'isVerified': isVerified,
        if (departments != null) 'departments': departments,
        if (about != null) 'about': about,
      };
}
