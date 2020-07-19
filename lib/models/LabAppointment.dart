import 'dart:io';

abstract class LabAppointmentModel {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String address;
  File image1;
  File image2;
}

class LabAppointment implements LabAppointmentModel {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String address;
  File image1;
  File image2;

  LabAppointment(this.date, this.time, this.address, this.firstName,
      this.lastName, this.phoneNum, this.image1, this.image2);

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'date': date,
        'lastName': lastName,
        'address': address,
        'image1': image1,
        'image2': image2
      };

  LabAppointment.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        date = json['date'].toDate(),
        address = json['address'],
        phoneNum = json['phoneNum'];
}
