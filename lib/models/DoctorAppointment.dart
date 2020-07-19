abstract class DoctorAppointmentModel {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String doctor;
  String department;
  String hospital;
  String gender;
  String consultationType;
}

class DoctorAppointment implements DoctorAppointmentModel {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String doctor;
  String department;
  String hospital;
  String gender;
  String consultationType;

  DoctorAppointment(
    this.date,
    this.time,
    this.department,
    this.doctor,
    this.gender,
    this.consultationType,
    this.firstName,
    this.hospital,
    this.lastName,
    this.phoneNum,
  );

  // formatting for upload to Firbase when creating the Doctorappointment
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'phoneNum': phoneNum,
        'date': date,
        'lastName': lastName,
        'hospital': hospital,
        'department': department,
        'doctor': doctor,
        'gender': gender,
        'time': time,
        'consultationType': consultationType
      };

  DoctorAppointment.fromJson(json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        date = json['date'].toDate(),
        hospital = json['hospital'],
        department = json['department'],
        doctor = json['doctor'],
        gender = json['gender'],
        consultationType = json['consultationType'],
        phoneNum = json['phoneNum'];
}
