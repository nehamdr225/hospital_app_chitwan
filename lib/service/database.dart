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

  static Future updateUserData(String uid, Map<String, dynamic> data) async {
    return await userCollection.document(uid).setData(data);
  }

  static Future<DocumentSnapshot> getUserData(String uid) async {
    return await userCollection.document(uid).get();
  }

  static Future updateDoctorData(String uid, Map<String, dynamic> data) async {
    return await doctorCollection.document(uid).setData(data);
  }

  static Future updateHospitalData(
      String uid, Map<String, dynamic> data) async {
    return await hospitalCollection.document(uid).setData(data);
  }

  static Future updatePharmacyData(
      String uid, Map<String, dynamic> data) async {
    return await pharmacyCollection.document(uid).setData(data);
  }

  static Future createAppointment(Map data) async {
    try {
      return await appointmentCollection.document().setData(data);
    } catch (e) {
      return 'error';
    }
  }

  static Future getAppointments(String uid) {
    return appointmentCollection.document(uid).get();
  }

  static Stream<QuerySnapshot> getDoctors() {
    return doctorCollection.snapshots();
  }

  static getDoctorsByHospital(String hospital) {
    return doctorCollection.where('hospital', isEqualTo: hospital);
  }

  static Stream<QuerySnapshot> getHospitals() {
    return hospitalCollection.snapshots();
  }
}
