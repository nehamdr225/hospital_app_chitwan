import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacyRemark {
  String remark;

  PharmacyRemark(this.remark);

  // formatting for upload to Firbase when creating the PharmacyRemark
  Map<String, dynamic> toJson() => {'remark': remark};

  // creating a Trip object from a firebase snapshot
  PharmacyRemark.fromSnapshot(DocumentSnapshot snapshot)
      : remark = snapshot['remark'];

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
