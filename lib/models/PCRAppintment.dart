import 'package:chitwan_hospital/UI/pages/AppointmentPages/PCRAppointment.dart';
import 'package:chitwan_hospital/service/extensions.dart';

abstract class PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  Gender gender;
  String email;
  String dob;
  String age;
  String temporaryAddress;
  String permanentAddress;
  String admittedHospital;
  String occupation;
  String status;
  BoolEnum previousTravel;
  BoolEnum closeContactToProbable;
  BoolEnum liveMarketVisit;
  DateTime date;
}

class PCRAppointment implements PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  Gender gender;
  String status;
  String email;
  String dob;
  String age;
  String temporaryAddress;
  String permanentAddress;
  String admittedHospital;
  String occupation;
  BoolEnum previousTravel;
  BoolEnum closeContactToProbable;
  BoolEnum liveMarketVisit;
  DateTime date;
  PCRAppointment({
    this.date,
    this.gender,
    this.firstName,
    this.lastName,
    this.phoneNum,
    this.status,
    this.id,
    this.userId,
    this.admittedHospital,
    this.age,
    this.closeContactToProbable,
    this.dob,
    this.email,
    this.liveMarketVisit,
    this.occupation,
    this.permanentAddress,
    this.previousTravel,
    this.temporaryAddress,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'date': date,
        'lastName': lastName,
        'gender': gender.string,
        'email': email,
        'dob': dob,
        'age': age,
        'temporaryAddress': temporaryAddress,
        'permanentAddress': permanentAddress,
        'admittedHospital': admittedHospital,
        'occupation': occupation,
        'previousTravel': previousTravel.boolean,
        'liveMarketVisit': liveMarketVisit.boolean,
        'closeContactToProbable': closeContactToProbable.boolean,
        if (status != null) 'status': status,
        if (id != null) 'id': id,
        if (userId != null) 'userId': userId,
      };

  PCRAppointment.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        date = json['date'].toDate(),
        gender = (Gender.male).fromString(json['gender']),
        phoneNum = json['phoneNum'],
        status = json['status'],
        id = json['id'],
        userId = json['userId'],
        admittedHospital = json['admittedHospital'],
        age = json['age'],
        closeContactToProbable =
            (BoolEnum.no).fromBoolean(json['closeContactToProbable']),
        dob = json['dob'],
        email = json['email'],
        liveMarketVisit = (BoolEnum.no).fromBoolean(json['liveMarketVisit']),
        occupation = json['occupation'],
        permanentAddress = json['permanentAddress'],
        previousTravel = (BoolEnum.no).fromBoolean(json['previousTravel']),
        temporaryAddress = json['temporaryAddress'];
}
