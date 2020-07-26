import 'dart:io';

abstract class LabAppointmentModel {
  String id;
  String name;
  String phone;
  String timestamp;
  String address;
  String status;
  String remark;
  String email;
  String title;
  File image;
}

class LabAppointment implements LabAppointmentModel {
  String id;
  String name;
  String phone;
  String email;
  String timestamp;
  String address;
  String status;
  String remark;
  String title;
  File image;

  LabAppointment({
    this.id,
    this.timestamp,
    this.address,
    this.name,
    this.phone,
    this.image,
    this.status,
    this.remark,
    this.email,
    this.title,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'address': address,
        'timestamp': timestamp,
        'email': email,
        'title': title,
        if (image != null) 'image': image,
        if (id != null) 'id': id,
        if (status != null) 'status': status,
        if (remark != null) 'remark': remark,
      };

  LabAppointment.fromJson(json)
      : name = json['name'],
        timestamp = json['timestamp'],
        address = json['address'],
        phone = json['phone'],
        image = json['image'],
        id = json['id'],
        status = json['status'],
        email = json['email'],
        title = json['title'];
}
