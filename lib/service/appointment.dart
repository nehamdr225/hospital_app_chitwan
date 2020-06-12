import 'package:cloud_firestore/cloud_firestore.dart';


class Appointments {
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

  Appointments(
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

  // formatting for upload to Firbase when creating the appointments
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'phoneNum': phoneNum,
    'date': date,
    'lastName': lastName,
    'hospital': hospital,
    'department': department,
    'doctor': doctor,
    'gender': gender,
  };

  // creating a Trip object from a firebase snapshot
  Appointments.fromSnapshot(DocumentSnapshot snapshot) :
      firstName = snapshot['firstName'],
      lastName = snapshot['lastName'],
      date = snapshot['date'].toDate(),
      hospital = snapshot['hospital'],
      department = snapshot['department'],
      doctor = snapshot['doctor'],
      gender = snapshot['gender'],
      consultationType = snapshot['consultationType'],
      phoneNum = snapshot['phoneNum'];



  // Map<String, Icon> types() => {
  //   "car": Icon(Icons.directions_car, size: 50),
  //   "bus": Icon(Icons.directions_bus, size: 50),
  //   "train": Icon(Icons.train, size: 50),
  //   "plane": Icon(Icons.airplanemode_active, size: 50),
  //   "ship": Icon(Icons.directions_boat, size: 50),
  //   "other": Icon(Icons.directions, size: 50),
  // };

  // return the google places image
  // Image getLocationImage() {
  //   final baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
  //   final maxWidth = "1000";
  //   //final url = "$baseUrl?maxwidth=$maxWidth&photoreference=$photoReference&key=$PLACES_API_KEY";
  //   //return Image.network(url, fit: BoxFit.cover);
  // }
}
