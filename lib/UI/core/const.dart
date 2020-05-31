import 'package:flutter/material.dart';
var loggedIn = true;
var doctorDecision =  "undecided"; //doctor has accepted the patient request

const NearYou = [
  {
    "name": "Dr. Bharati Devi Sharma",
    "cap": "Operation Theater",
    "phone": "9841347147",
    "src": "assets/images/bakery.jpg",
    "status": "Accepted",
    "date": "07-05-2020",
    "time": "10:00 am",
    "gender": "Female",
  },
  {
    "name": "Dr. Amit Jha",
    "cap": "ENT",
    "phone": "9841347147",
    "src": "assets/images/barber.jpg",
    "status": "Accepted",
    "date": "10-05-2020",
    "time": "05:00 pm",
    "gender": "Male",
  },
  {
    "name": "Dr. Sangeeta Paudel",
    "cap": "Dermatology",
    "phone": "9841347147",
    "src": "assets/images/spa.jpg",
    "status": "Cancelled",
    "date": "19-04-2020",
    "time": "08:00 pm",
    "gender": "Female",
  },
];

const PrescriptionData = [
  {
    "name": "Mrs. Bharati Devi Sharma",
    "cap": "OPD", // department if not from any department then OPD
    "phone": "9841347147",
    "src": "assets/images/bakery.jpg",
    "status": "Ready",
    "date": "07-05-2020",
    "time": "10:00 am",
    "take": "Asile 1"
  },
  {
    "name": "Mr. Amit Jha",
    "cap": "ENT",
    "phone": "9841347147",
    "src": "assets/images/barber.jpg",
    "status": "Processing",
    "date": "10-05-2020",
    "time": "05:00 pm",
    "take": "Asile 4"
  },
  {
    "name": "Ms. Sangeeta Paudel",
    "cap": "Dermatology",
    "phone": "9841347147",
    "src": "assets/images/spa.jpg",
    "status": "Ready",
    "date": "19-04-2020",
    "time": "08:00 pm",
    "take": "Asile 2"
  },
];

const Options = [
  {
    "name": "Doctors",
    "cap": "Doctors",
    "src": "assets/images/Qdoctors.png",
    "id":0
  },
  {
    "name": "Pharmacy",
    "cap": "Pharmacy",
    "src": "assets/images/Qpharmacy.png",
    "id":1
  },
  {
    "name": "Ambulance",
    "cap": "Ambulance",
    "src": "assets/images/Qambulance.png",
    "id":2
  },
  {
    "name": "Laboratory",
    "cap": "Laboratory",
    "src": "assets/images/QLab.png",
    "id":3
  },
  {
    "name": "Hospital",
    "cap": "Hospital",
    "src": "assets/images/Qhospital.png",
    "id":4
  },
  {
    "name": "Blood Bank",
    "cap": "Blood Bank",
    "src": "assets/images/QbloodBank.png",
    "id":5
  },
];

const Doctor_Tab = [
  {
    "name": "Ayurveda",
    "cap": "Ayurveda",
    "src": "assets/images/Qdoctors.png",
    "id":0
  },
  {
    "name": "Cardiologist",
    "cap": "Cardiologist",
    "src": "assets/images/Qpharmacy.png",
    "id":1
  },
  {
    "name": "Dentist",
    "cap": "Dentist",
    "src": "assets/images/Qambulance.png",
    "id":2
  },
  {
    "name": "Dermatologist",
    "cap": "Dermatologist",
    "src": "assets/images/QLab.png",
    "id":3
  },
  {
    "name": "Eye Care",
    "cap": "Eye Care",
    "src": "assets/images/Qhospital.png",
    "id":4
  },
  {
    "name": "Endocrinologist",
    "cap": "Endocrinologist",
    "src": "assets/images/QbloodBank.png",
    "id":5
  },
];

class Doodle {
  final String name;
  final String time;
  final String diagnosis;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {this.name,
      this.time,
      this.diagnosis,
      this.doodle,
      this.icon,
      this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
      name: "Bharati Devi Sharma",
      time: "07-05-2020, 10:00 am",
      diagnosis:
          "High Blood Pressure",      
      iconBackground: Color(0xff173A7B),),
  Doodle(
      name: "Sangeeta Paudel",
      time: "19-04-2020, 08:00 pm",
      diagnosis:
          "Dermatology",      
      iconBackground: Color(0xff173A7B),),
  Doodle(
      name: "Amit Jha",
      time: "10-05-2020, 05:00 PM",
      diagnosis:
          "Diabetic",
      // doodle:
      //     "rthday-5436382608621568-hp2x.jpg",
      iconBackground: Color(0xff173A7B),),

];
