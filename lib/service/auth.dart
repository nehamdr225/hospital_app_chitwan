import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'user.dart';


class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null? User(uid:user.uid): null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }
  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

   // Sign In with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // signup with email and password
  Future registerWithEmailAndPassword(String email, String password, String name, String phone) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, email, phone);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  


}