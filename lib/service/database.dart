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

  static Future<DocumentSnapshot> getDoctorData(String uid) async {
    return await doctorCollection.document(uid).get();
  }

  static Future<DocumentSnapshot> getHospitalData(String uid) async {
    return await hospitalCollection.document(uid).get();
  }

  static Future updateDoctorData(String uid, data) async {
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

  static Stream<QuerySnapshot> getAppointments(String uid) {
    final result = appointmentCollection.where('userId', isEqualTo: uid);
    return result.snapshots();
  }

  static Stream<QuerySnapshot> getDoctors() {
    return doctorCollection.snapshots();
  }

  static Stream<QuerySnapshot> getDoctorAppointments(String uid) {
    final result = appointmentCollection.where('doctorId', isEqualTo: uid);
    return result.snapshots();
  }

  static getDoctorsByHospital(String hospital) {
    return doctorCollection.where('hospital', isEqualTo: hospital);
  }

  static Future<bool> markDoctorVerified(String id) async {
    try {
      await doctorCollection.document(id).updateData({'isVerified': true});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<QuerySnapshot> getHospitals() {
    return hospitalCollection.snapshots();
  }

  static Future<bool> setAppointmentStatus(String uid, dynamic status) async {
    try {
      await appointmentCollection.document(uid).setData({status: status});
      print('done');
      return true;
    } catch (e) {
      return false;
    }
  }
}
