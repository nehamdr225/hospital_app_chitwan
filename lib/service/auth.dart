import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'user.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<String> getCurrentUID() async {
    try {
      final currentUser = await _auth.currentUser();
      if (currentUser != null) {
        return currentUser.uid;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

  // Sign In with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signup with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'user',
      };

      await DatabaseService.updateUserData(user.uid, userData);
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    final userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  // signup with email and password
  Future registerDoctor(
      {String email,
      String password,
      String name,
      String phone,
      String hospital}) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updateDoctorData(user.uid, {
        'phone': phone,
        'role': 'doctor',
        'isVerified': false,
        'name': name,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// signup with email and password
  Future registerHospital({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updateHospitalData(user.uid, {
        'phone': phone,
        'role': 'hospital',
        'name': name,
        'isVerified': false,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerPharmacy({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updatePharmacyData(user.uid, {
        'phone': phone,
        'role': 'pharmacy',
        'name': name,
        'isVerified': false,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
