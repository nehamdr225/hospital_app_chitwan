abstract class PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String gender;
  String status;
}

class PCRAppointment implements PCRAppointmentModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String gender;
  String status;
  PCRAppointment({
    this.date,
    this.time,
    this.gender,
    this.firstName,
    this.lastName,
    this.phoneNum,
    this.status,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'date': date,
        'lastName': lastName,
        'gender': gender,
        'time': time,
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
        time = json['time'];
}
