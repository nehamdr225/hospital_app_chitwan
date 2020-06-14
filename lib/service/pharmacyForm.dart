import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';


class Pharmacy {
  String firstName;
  String lastName;
  String phoneNum;
  DateTime date;
  String time;
  String address;
  File image1;
  File image2;
  

  Pharmacy(
      this.date,
      this.time,
      this.address,
      this.firstName,
      this.lastName, 
      this.phoneNum,
      this.image1,
      this.image2
      );

  // formatting for upload to Firbase when creating the Pharmacy
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'phoneNum': phoneNum,
    'date': date,
    'lastName': lastName,
    'address': address,
    'image1': image1,
    'image2': image2
  };

  // creating a Trip object from a firebase snapshot
  Pharmacy.fromSnapshot(DocumentSnapshot snapshot) :
      firstName = snapshot['firstName'],
      lastName = snapshot['lastName'],
      date = snapshot['date'].toDate(),
      address = snapshot['address'],
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
