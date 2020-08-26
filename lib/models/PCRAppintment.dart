abstract class PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  String gender;
  String email;
  String dob;
  String age;
  String temporaryAddress;
  String permanentAddress;
  String admittedHospital;
  String occupation;
  String status;
  bool previousTravel;
  bool closeContactToProbable;
  bool liveMarketVisit;
  DateTime date;
}

class PCRAppointment implements PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  String gender;
  String status;
  String email;
  String dob;
  String age;
  String temporaryAddress;
  String permanentAddress;
  String admittedHospital;
  String occupation;
  bool previousTravel;
  bool closeContactToProbable;
  bool liveMarketVisit;
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
        'gender': gender,
        'email': email,
        'dob': dob,
        'age': age,
        'temporaryAddress': temporaryAddress,
        'permanentAddress': permanentAddress,
        'admittedHospital': admittedHospital,
        'occupation': occupation,
        'previousTravel': previousTravel,
        'liveMarketVisit': liveMarketVisit,
        'closeContactToProbable': closeContactToProbable,
        if (status != null) 'status': status,
        if (id != null) 'id': id,
        if (userId != null) 'userId': userId,
      };

  PCRAppointment.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        date = json['date'].toDate(),
        gender = json['gender'],
        phoneNum = json['phoneNum'],
        status = json['status'],
        id = json['id'],
        userId = json['userId'],
        admittedHospital = json['admittedHospital'],
        age = json['age'],
        closeContactToProbable = json['closeContactToProbable'],
        dob = json['dob'],
        email = json['email'],
        liveMarketVisit = json['liveMarketVisit'],
        occupation = json['occupation'],
        permanentAddress = json['permanentAddress'],
        previousTravel = json['previousTravel'],
        temporaryAddress = json['temporaryAddress'];
}
