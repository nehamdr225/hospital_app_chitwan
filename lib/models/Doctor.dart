import 'package:chitwan_hospital/models/User.dart';

abstract class DoctorModel extends UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;

  String address;
  String consultationType;
  String department;
  bool isVerified;
  String registrationNo;
  String hospital;
}

class Doctor implements DoctorModel {
  String uid;
  String name;
  String email;
  String phone;
  String role;

  String address;
  String consultationType;
  String department;
  bool isVerified;
  String registrationNo;
  String hospital;

  Doctor.fromJson(json)
      : this.uid = json['id'],
        this.name = json['name'],
        this.email = json['email'],
        this.phone = json['phone'] ?? null,
        this.role = json['role'] ?? null,
        this.address = json['address'] ?? null,
        this.consultationType = json['consultationType'] ?? null,
        this.department = json['department'] ?? null,
        this.isVerified = json['isVerified'] ?? null,
        this.registrationNo = json['registrationNo'],
        this.hospital = json['hospital'];

  Map toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        if (address != null) 'address': address,
        if (consultationType != null) 'consultationType': consultationType,
        if (department != null) 'department': department,
        if (isVerified != null) 'isVerified': isVerified,
        if (registrationNo != null) 'registrationNo': registrationNo,
        if (hospital != null) 'hospital': hospital,
      };
}
