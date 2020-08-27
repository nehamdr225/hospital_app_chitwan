import 'package:chitwan_hospital/UI/pages/AppointmentPages/PCRAppointment.dart';
import 'package:chitwan_hospital/service/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Occupation occupation;
  String otherOccupation;
  String status;
  BoolEnum previousTravel;
  String placeOfTravel;
  BoolEnum closeContactToProbable;
  CloseContactDetails closeContactDetails;
  BoolEnum liveMarketVisit;
  String liveMarketLocation;
  Timestamp timestamp;
  ContactSeeting contactSeeting;
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
  Occupation occupation;
  String otherOccupation;
  BoolEnum previousTravel;
  String placeOfTravel;
  BoolEnum closeContactToProbable;
  CloseContactDetails closeContactDetails;
  BoolEnum liveMarketVisit;
  String liveMarketLocation;
  Timestamp timestamp;
  ContactSeeting contactSeeting;
  PCRAppointment(
      {this.timestamp,
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
      this.closeContactDetails,
      this.liveMarketLocation,
      this.otherOccupation,
      this.placeOfTravel,
      this.contactSeeting});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'timestamp': timestamp,
        'lastName': lastName,
        'gender': gender.string,
        'email': email,
        'dob': dob,
        'age': age,
        'temporaryAddress': temporaryAddress,
        'permanentAddress': permanentAddress,
        'admittedHospital': admittedHospital,
        'occupation': occupation.string,
        'previousTravel': previousTravel.boolean,
        'liveMarketVisit': liveMarketVisit.boolean,
        'closeContactToProbable': closeContactToProbable.boolean,
        'contactSeeting': contactSeeting.toJson(),
        if (occupation.string == 'Others') 'otherOccupation': otherOccupation,
        if (previousTravel.boolean) 'placeOfTravel': placeOfTravel,
        if (liveMarketVisit.boolean) 'liveMarketLocation': liveMarketLocation,
        if (closeContactToProbable.boolean)
          'closeContactDetails': closeContactDetails.toJson(),
        if (status != null) 'status': status,
        if (id != null) 'id': id,
        if (userId != null) 'userId': userId,
      };

  PCRAppointment.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        timestamp = json['timestamp'],
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
        occupation = (Occupation.others).fromString(json['occupation']),
        permanentAddress = json['permanentAddress'],
        previousTravel = (BoolEnum.no).fromBoolean(json['previousTravel']),
        temporaryAddress = json['temporaryAddress'],
        otherOccupation = json['otherOccupation'],
        placeOfTravel = json['placeOfTravel'],
        liveMarketLocation = json['liveMarketLocation'],
        closeContactDetails =
            CloseContactDetails.fromJson(json['closeContactDetails']),
        contactSeeting = ContactSeeting.fromJson(json['contactSeeting']);
}

class CloseContactDetails {
  String probableCases, exposedLocation;

  CloseContactDetails({this.exposedLocation, this.probableCases});

  CloseContactDetails.fromJson(json)
      : this.probableCases = json['probableCases'],
        this.exposedLocation = json['exposedLocation'];

  Map<String, String> toJson() => {
        'probableCases': this.probableCases,
        'exposedLocation': this.exposedLocation,
      };
}

class ContactSeeting {
  bool healthCare;
  bool family;
  bool workPlace;
  bool unknown;

  ContactSeeting({this.family, this.healthCare, this.unknown, this.workPlace});

  ContactSeeting.fromJson(json)
      : this.family = json['family'],
        this.healthCare = json['healthCare'],
        this.unknown = json['unknown'],
        this.workPlace = json['workPlace'];

  Map<String, bool> toJson() => {
        'family': this.family,
        'healthCare': this.healthCare,
        'unknown': this.unknown,
        'workPlace': this.workPlace,
      };
}
