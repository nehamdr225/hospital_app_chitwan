import 'package:eMed/models/User.dart';

abstract class PharmacyModel extends UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;

  String address;
  bool isVerified;
  String registrationNo;
  String openHours;
}

class Pharmacy implements PharmacyModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;

  String address;
  bool isVerified;
  String registrationNo;
  String openHours;

  Pharmacy.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'] ?? null,
        this.role = json['role'] ?? null,
        this.address = json['address'] ?? null,
        this.isVerified = json['isVerified'] ?? null,
        this.registrationNo = json['registrationNo'],
        this.openHours = json['openHours'];

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        if (address != null) 'address': address,
        if (isVerified != null) 'isVerified': isVerified,
        if (registrationNo != null) 'registrationNo': registrationNo,
        if (openHours != null) 'openHours': openHours,
      };
}
