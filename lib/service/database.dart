import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final Firestore db = Firestore.instance;
  static final CollectionReference userCollection = db.collection('users');
  static final CollectionReference doctorCollection = db.collection('doctors');
  static final CollectionReference labCollection = db.collection('labs');
  static final CollectionReference bloodCollection = db.collection('bloods');
  static final CollectionReference appointmentCollection =
      db.collection('appointments');
  static final CollectionReference hospitalCollection =
      db.collection('hospitals');
  static final CollectionReference ambulanceCollection =
      db.collection('ambulances');
  static final CollectionReference pharmacyCollection =
      db.collection('pharmacies');

  static Future updateUserData(String uid, String email, String phone) async {
    return await userCollection
        .document(uid)
        .setData({'email': email, 'phone': phone});
  }

  static Future createAppointment(Map data) async {
    return await appointmentCollection.document().setData(data);
  }

  static getDoctors() {
    return doctorCollection.snapshots();
  }
}
