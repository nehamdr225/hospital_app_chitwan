import 'package:cloud_firestore/cloud_firestore.dart';

class BloodRequest {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String address;
  String bloodGroup;

  BloodRequest(
      this.date,
      this.time,
      this.address,
      this.firstName,
      this.lastName, 
      this.phoneNum,
      this.bloodGroup
      );

  // formatting for upload to Firbase when creating the BloodRequest
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'phoneNum': phoneNum,
    'date': date,
    'lastName': lastName,
    'address': address,
    'bloodGroup': bloodGroup
  };

  // creating a Trip object from a firebase snapshot
  BloodRequest.fromSnapshot(DocumentSnapshot snapshot) :
      firstName = snapshot['firstName'],
      lastName = snapshot['lastName'],
      date = snapshot['date'].toDate(),
      address = snapshot['address'],
      phoneNum = snapshot['phoneNum'],
      bloodGroup = snapshot['bloodGroup'];



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
